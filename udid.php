<?php

/*使用说明=====
1.将本文件udid.php 和1.mobileprovision 上传到域名根目录或任意二级目录
2.修改 $签名  $数据库表前缀 2个参数。

/*其他说明====
1.mobileprovision 是任意一个未掉签企业签名的描述文件
重命名为1.mobileprovision即可 如果企业掉签 则用户下载描述文件后 没法自动跳转到设置 需要手动打开iOS系统设置
***1.mobileprovision 仅仅是为了方便打开iOS系统设置 不影响获取udid

/*签名说明====
描述文件是否需要签名 1需要2不需要
签名不签名不影响获取UDID 只是不签名安装的时候提示描述文件未签名 红色 签名就打勾绿色
如果需要签名 设置为1 并且准备一个ssl域名证书 如果使用宝塔面板 并且使用域名非IP
直接打开宝塔后台 网站-设置-SSL-按要求域名解析 -使用宝塔SSL 或Let's Encrypt一键申请


/*签名设置====
申请成功后SSL证书后

需要把密钥(KEY) 写到一个txt文本并且改后缀key  名字为key.key 放在udid.php同级目录

需要把证书(PEM格式) 写到一个txt文本并且改后缀key  pem.pem 放在udid.php同级目录

********注意 如果需要签名 需要吧站点对应的php版本 禁用函数shell_exec() 删除
宝塔面板为例 -软件商店-已安装-PHP-设置-禁用函数 删除shell_exec()

*/

// 是否是需要签名 1需要 2不需要
$签名=1;
//$数据库表前缀 搭建BS 填写数据库时候的表前缀 默认bsphp_
$数据库表前缀="bsphp_";
?>



<?php
// 以下逻辑无需修改
$protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https://' : 'http://';
$domain = $_SERVER['HTTP_HOST'];
$path = $_SERVER['REQUEST_URI'];
$url = $protocol . $domain . $path;
// echo "当前页面的完整域名是：" . $url. "<br>";
$arr = explode("udid.php", $url);
$域名=$arr[0];
// echo "域名是：" . $域名. "<br>";
$数据库表前缀="bsphp_";
$doc_root = $_SERVER['DOCUMENT_ROOT'];
// echo "当前站点目录是：" . $doc_root. "<br>";
//自动加载数据库
include("$doc_root/Plug/Plug.php");

//获取URL参数
$id = isset($_GET['id']) ? trim($_GET['id']) : '';
$rm = isset($_GET['rm']) ? trim($_GET['rm']) : '';
$openurl = isset($_GET['openurl']) ? trim($_GET['openurl']) : '';
$daihao = isset($_GET['daihao']) ? trim($_GET['daihao']) : '';
$code = isset($_GET['code']) ? trim($_GET['code']) : '';
//判断是查询黑名单功能
if(strlen($code)>5){
    //获取udid=$code
    $sql="SELECT * FROM `".$数据库表前缀."pattern_login` WHERE `L_key_info` LIKE '$code' AND `L_class` != 0 AND `L_beizhu` LIKE '%黑%'";
    $info = plug_query_array($sql);
    if($info){
        if (strpos($info['L_beizhu'], '黑') !== false) {
            // echo "字符串包含 '黑' 黑名单用户";
        $code="黑名单用户".$info['L_beizhu']."联系管理员解除";
        
        }
    }
    
    
}
// 获取描述文件POST 参数
$data = file_get_contents('php://input');
$plistBegin   = '<string>';
$plistEnd   = '</string>';
$pos1 = strpos($data, $plistBegin);
$pos2 = strpos($data, $plistEnd);
$data2 = substr ($data,$pos1,$pos2-$pos1);
//解析出UDID
$UDID = str_replace("<string>", "", $data2);

//删除缓存-
if (strlen($rm) > 0 && strlen($rm) <= 50) {
    $dir = '.';
    $keyword = '/^' . preg_quote($rm, '/') . '$/';
    $count = 0;

    foreach (glob($dir . '/*.*') as $file) {
        
        if (is_file($file) && (strpos($file, $rm) !== false)) {
            // echo $file."<br>";
            
            if (unlink($file)) {
                // echo "File {$file} deleted successfully\n";
                $count++;
            } else {
                // echo "Failed to delete file {$file}\n";
            }
        }
    }

    if ($count > 0) {
        // echo "{$count} file(s) deleted successfully.";
    } else {
        // echo "No file deleted.";
    }
} else {
    // echo "Invalid parameter.";
}

//储存OPENURL 既跳转app的链接 和软件代号 到 用户id.txt
if(strlen($openurl)>5){
    $fp = fopen($id.'.txt', 'w');
    fwrite($fp, $openurl."|".$daihao);
    fclose($fp);
}
// UDID不为空证明获取到 跳转APP打开等后续操作
if(strlen($UDID)>10){
    //接收描述文件POST过来的数据
    $res = file_get_contents("./".$id.'.txt');//读取txt
    $keywords_array = explode("|", $res);//拆分openurl 和 软件代号
    $openurl=$keywords_array[0];
    $daihao=$keywords_array[1];
    $备注="";
    //查询是否在黑名单
    $sql="SELECT * FROM `".$数据库表前缀."pattern_login` WHERE `L_key_info` LIKE '$UDID' AND `L_class` != 0 AND `L_beizhu` LIKE '%黑%'";
    $info = plug_query_array($sql);
    if($info){
        //读取备注
        $备注=$info['L_beizhu'];
    }else{
        //没有备注
        $备注="";
    }
    //判断备注内容 包含关键字:黑 就是拉黑用户
    if (strpos($备注, '黑') !== false) {
        // echo "字符串包含 '黑' 黑名单用户";
        $write=$UDID."|老用户|黑名单用户|".$备注;
        
    } else {
        // echo "字符串不包含 '黑' 正常用户";
        //查询是否存在记录 存在就老用户 不存在 新用户
        $sql = "SELECT L_key_info FROM bsphp_pattern_login WHERE L_key_info = '$UDID' AND `L_daihao`='$daihao'";
        $info = plug_query_array($sql);
        if($info){
            //有记录
            $write=$UDID."|老用户|正常用户|".$备注;
            
        }else{
            //有记录
            $write=$UDID."|新用户|正常用户|".$备注;
            
        }
        
    }
        
    // 储存udid
    $fp = fopen("./udid".$id.'.txt', 'w');
    fwrite($fp, $write);
    fclose($fp);
    
    //判断是否为空 没有openurl 则是跳转会浏览器 提示用户自行打开APP
    if (strpos($res, 'null') !== false) {
        $url="Location: ".$域名."udid.php?id=null";
        header('HTTP/1.1 301 Moved Permanently');
        header($url);
    } else {
        $url="Location: ".$openurl."://";
        header('HTTP/1.1 301 Moved Permanently');
        header($url);
    }
    
    
}else{
    // UDID为空 创建描述文件 并提示下载描述文件
    
    $str="<dict >
        <key>PayloadContent</key>
        <dict>
            <key>URL</key>
            <string>".$域名."udid.php?id=".$id."</string>
            
            <key>DeviceAttributes</key>
            <array>
                <string>UDID</string>
            </array>
        </dict>
        
        
        <key>PayloadVersion</key>
        <integer>1</integer>
        
        <key>PayloadUUID</key>
        <string>c156f23f8-fc342-7545-8fc5-3256761d82933</string>
        
        <key>PayloadIdentifier</key>
        <string>获取UDID</string>
        
        <key>PayloadType</key>
        <string>Profile Service</string>
    </dict>";
    // 储存描述文件
    $fp = fopen("./".$id.'.mobileconfig', 'w');
    fwrite($fp, $str);
    fclose($fp);
    if($签名==1){
        
        if(!is_file('b.crt')){
            // echo "不存在 就读取证书PEM 拆分储存</br>";
            if(!is_file('pem.pem')){
                // echo "证书文件不存在 不签名</br>";
                $mobileconfig="./".$id.'.mobileconfig';
            }else{
                // echo "证书文件存在 读取进行拆分储存</br>";
                $res = file_get_contents('pem.pem');
                //替换
                $search = "/-----END CERTIFICATE-----/";
                $replace = "-----END CERTIFICATE--------";
                $result = preg_replace($search, $replace, $res, 1);
                
                //拆分证书文件
                $penarr=explode("-----END CERTIFICATE--------",$result);
                //储存前段部分为a.crt
                $fp = fopen("a.crt", 'w');
                $acrt=$penarr[0]."-----END CERTIFICATE-----";
                
                fwrite($fp, $acrt);
                fclose($fp);
                //储存后段部分为b.crt
                $carb=$penarr[1];
                $fp = fopen("b.crt", 'w');
                
                fwrite($fp,$carb );
                fclose($fp);
            }
            if (strpos($res, 'null') !== false) {
                $url="Location: ".$域名."udid.php?id=null";
                header('HTTP/1.1 301 Moved Permanently');
                header($url);
                
            }
        }
        
        //描述文件签名 key为网站证书key a.crt 为证书上部分 b.crt为证书下半部分
        $miss2=shell_exec("openssl smime -sign -in ".$id.".mobileconfig -out 2".$id.".mobileconfig -signer a.crt -inkey key.key  -certfile b.crt -outform der -nodetach");
        
        $mobileconfig="./2".$id.'.mobileconfig';
    }else{
        $mobileconfig="./".$id.'.mobileconfig';
    }
}

//判断企业描述文件是否存在 1.mobileprovision 存在就提示跳转iOS设置 没有就不提示
if(!is_file('1.mobileprovision')){
    // 文件不存
    $跳转="";
}else{
    //文件存在
    $跳转="./1.mobileprovision";
}

?>

<html lang="zh-cmn-Hans"><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0,viewport-fit=cover">
<meta name="wechat-enable-text-zoom-em" content="true">
    <title>IOS安全防护</title>
    
    </head>
    
    <body><div class="weui-msg">
    <div class="weui-msg__icon-area">
        <i id="icon" class="weui-icon-warn weui-icon_msg-primary"></i>
    </div>
    
    <div class="weui-msg__text-area">
    <h2 id="" class="weui-msg__title">UDID获取</h2>
    <p id="text" class="weui-msg__desc">如果安装失败请重新打开游戏<br>UDID仅作为授权码绑定标识符作用<br>请按照步骤安装<br><br><?php echo $code; ?>
    </p>
    </div>
    
    <div class="weui-msg__opr-area">
    <p class="weui-btn-area">
    <!--<a href="https://udid.nuosike.cn/api/url/signed.mobileconfig" role="button" class="weui-btn weui-btn_primary" style="bottom: 200px !important;" onclick="jump()">点击安装</a>-->
    <button id="button" role="button" class="weui-btn weui-btn_primary" style="bottom: 200px !important;" onclick="jump()">点击安装</button>
    </p>
    
    </div>
    <div class="weui-msg__tips-area">
    <p class="weui-msg__tips">承接iOS软件开发 验证对接 Php Html Js开发</p>
    </div>
    
    <div class="weui-msg__extra-area">
    <div class="weui-footer">
    <p class="weui-footer__links">
    <!--<a href="index.json" class="weui-wa-hotarea weui-footer__link">www.speed-v.com</a>-->
    </p>
    
    <p class="weui-footer__text">Copyright ©2023 By 十三哥 WX:NongShiFu123 QQ350722326</p>
    </div>
    </div>
    </div>
    
    <script type="text/javascript">
    var jump = function() {
        setTimeout("自动跳转()", 1000);
　　    window.location.href="<?php echo $mobileconfig; ?>";
        }
        function 自动跳转(){
　　    window.location.href="<?php echo $跳转; ?>";
　　    
　　};
　　
</script>
<script type="text/javascript">

        (function(){
            var mingzi="<?php echo $id; ?>";
            if(mingzi.indexOf("null") != -1 ){
                var title=document.getElementById("button");
                title.innerHTML='获取成功';
                var text=document.getElementById("text");
                text.innerHTML='请重开APP生效';
                var icon=document.getElementById("icon");
                icon.className ='weui-icon-success weui-icon_msg-primary';
                
            }
            
            document.write("<link rel='stylesheet'  href='https://myradar.cn/UDID/example.css?id=" + Date.now() + "'>");
            document.write("<link rel='stylesheet'  href='https://myradar.cn/UDID/weui.min.css?id=" + Date.now() + "'>");
        })();
        </script>
</body></html>

