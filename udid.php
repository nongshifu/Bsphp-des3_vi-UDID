<?php

/*
将本文件udid.php 和1.mobileprovision 上传到域名根目录或二级目录 填写 $签名 $域名 两个配置
 1.mobileprovision 是一个企业签名的描述文件 不能编辑 仅作为跳转 如果不上传 安装描述文件后需要手动打开设置-描述文件
 如果上传1.mobileprovision了 安装描述文件后会自动跳转到对应描述文件 方便
 
描述文件是否需要签名 1需要2不需要
签名不签名不影响获取UDID 只是不签名安装的时候提示描述文件未签名 红色 签名就打勾绿色
如果需要签名 设置为1 并且准备一个ssl域名证书 如果使用宝塔面板 并且使用域名非IP
直接打开宝塔后台 网站-设置-SSL-按要求域名解析 -使用宝塔SSL 或Let's Encrypt一键申请

申请成功后 需要把密钥(KEY) 写到一个txt文本并且改后缀key  名字为key.key 放在udid.php同级目录

需要把证书(PEM格式) 拆分为二
前段部分
从-----BEGIN CERTIFICATE-----开始到-----END CERTIFICATE-----储存为a.crt
后段部分
从-----BEGIN CERTIFICATE-----开始到-----END CERTIFICATE-----储存为b.crt
为a.crt 和b.crt 放在udid.php同级目录 以下 $签名=1 即可自动签名

如果你使用的验证系统是直接使用IP形式作为域名 那就自己买个域名吧
但是com cn 等后缀的顶级 域名绑定国内服务器需要备案的 只能绑定非大陆服务器 香港台湾或者国外
可以单独买个超级便宜甚至免费那种的非大陆服务器 仅作为获取UDID使用足够的
和BSPHP 的验证服务器分开不影响 只要修改一下 $域名="https://baidu.cn/UDID/";为你国外服务器域名即可

*/
// 是否是需要签名
$签名=1;
// 填写你UDID文件的域名和目录 如你上传到域名根目录的UDID文件夹下 填写 域名/UDID/
$域名="https://myradar.cn/UDID/";
// 本文件可以上传到任意二级目录或网站根目录都行
// 二级三级目录就设置好比如 $域名="https://baidu.cn/二级目录/三级目录/ 注意尾部一定有/符号
?>

<?php
// 以下逻辑无需修改
$id=$_GET["id"];
$openurl=$_GET["openurl"];
$data = file_get_contents('php://input');
$plistBegin   = '<string>';
$plistEnd   = '</string>';

$pos1 = strpos($data, $plistBegin);
$pos2 = strpos($data, $plistEnd);
$data2 = substr ($data,$pos1,$pos2-$pos1);
$UDID = str_replace("<string>", "", $data2);

//储存OPENURL
if(strlen($openurl)>5){
    $fp = fopen($id.'.txt', 'w');
    fwrite($fp, $openurl);
    fclose($fp);
}
// UDID不为空 跳转APP打开
if(strlen($UDID)>5){
    // 储存udid
    $fp = fopen("./udid".$id.'.txt', 'w');
    fwrite($fp, $UDID);
    fclose($fp);
    
    $res = file_get_contents("./".$id.'.txt');
    if (strpos($res, 'null') !== false) {
        $url="Location: ".$域名."udid.php?id=null";
        header('HTTP/1.1 301 Moved Permanently');
        header($url);
    } else {
        $url="Location: ".$res."://";
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
        //描述文件签名 key为网站证书key a.crt 为证书上部分 b.crt为证书下半部分
        $miss2=shell_exec("openssl smime -sign -in ".$id.".mobileconfig -out 2".$id.".mobileconfig -signer a.crt -inkey key.key  -certfile b.crt -outform der -nodetach");
        $mobileconfig="./2".$id.'.mobileconfig';
    }else{
        $mobileconfig="./".$id.'.mobileconfig';
    }
}

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
    <h2 class="weui-msg__title">UDID获取</h2>
    <p id="text" class="weui-msg__desc">如果安装失败请重新打开游戏<br>UDID仅作为授权码绑定标识符作用<br>请按照步骤安装<br>
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
            
            document.write("<link rel='stylesheet'  href='example.css?id=" + Date.now() + "'>");
            document.write("<link rel='stylesheet'  href='weui.min.css?id=" + Date.now() + "'>");
        })();
        </script>
</body></html>

