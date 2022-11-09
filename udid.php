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
if(strlen($UDID)>10){
    // 储存udid
    $fp = fopen("./udid".$id.'.txt', 'w');
    fwrite($fp, $UDID);
    fclose($fp);
    
    $res = file_get_contents("./".$id.'.txt');
    $url="Location: ".$res."://";
    header('HTTP/1.1 301 Moved Permanently');
    header($url);
    
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
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>获取UDID</title>
    <link rel="stylesheet" href="https://bbs.pediy.com/view/css/bootstrap.css">
    <link rel="stylesheet" href="https://bbs.pediy.com/view/css/bootstrap-bbs.css">
    <style>
        button {
            font-size : 30px;
            width: 100%;
            
            
            color: #ff0000
            font-size: 40px;
            
            background-color: #00ff00;
            border-radius: 10px
        }
        
        .container {
            width: 60%;
            margin: 10% auto 0;
            background-color: #f0f0f0;
            padding: 2% 5%;
            border-radius: 10px
        }
        .container2 {
            width: 100%;
            margin: 10% auto 0;
            /*background-color: #f0f0f0;*/
            padding: 10px 10px;
            border-radius: 10px
        }

        ul {
            padding-left: 20px;
        }

            ul li {
                line-height: 2.3
            }

        a {
            /*font-size: 40px;*/
            /*color: #20a53a*/
        }
    </style>
</head>
<body>
    <div class="container">
        
        <button type="button" nclick="下载()" id="button">获取UDID</button>
        <br><br>
        <h3>  安装描述文件引导，获取设备UDID</h3>
        <ul>
            <li>1 安装描述文件授权获取UDID时，如提示密码即您的锁屏密码</li>
            <li>2 描述文件安装路径为 设置-通用-设备与描述文件管理</li>
            <li>3 如果安装时间过长或者提示安装失败请直接返回App</li>
            <li>4 下载好描述文件后请前往 系统设置-通用-设备与描述文件管理 找到并安装此描述文件</li>
            
        </ul>
        <button type="button"  onclick="下载()" id="button">点我-下载描述文件</button>
        
    </div>
<footer id="footer" style="background: #3b4348; color: #9ba4aa; height: auto;">
    <div class="container2">
        <div class="row text-muted small my-3 mx-0" id="web_base_company_information">
            <div class="col-12 col-md-6">
                ©2000-2022 UDID验证系统 技术支持：十三哥&nbsp;<br>
<a href="https://github.com/nongshifu" target="_blank" class="text-muted">GitHub |&nbsp;</a>
<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=&amp;site=qq&amp;menu=yes" target="_blank" class="text-muted">QQ:350722326 |&nbsp;</a>
<a class="text-muted">微信:NongShiFu123&nbsp;</a>


            </div>
            <div class="col-12 col-md-6 pt-2 pt-md-0 text-md-right">
                
                <span><a class="text-muted">承接业务</a></span> |
                <span><a class="text-muted">验证系统开发</a></span> |
                <span>软件开发</span> |
                <a class="text-muted">iOS开发</a> |
                <a class="text-muted">越狱开发</a> |
                <a class="text-muted">网页HTML5开发</a> <br>辅助开发<b>&nbsp;|&nbsp;</b>PHP开发&nbsp;<b>|</b><a class="text-muted" target="_blank">&nbsp;H5GG脚本开发&nbsp;</a><a class="text-muted" target="_blank">最稳的技术给你最低的价格</a>

            </div>
        </div>
        <div style="max-height: 100px; overflow-y:auto;">
                    </div>
    </div>
</footer>
<script>
　　function 下载(){
　　    setTimeout("自动跳转()", 1000);
　　    window.location.href="<?php echo $mobileconfig; ?>";
　　};
　　function 自动跳转(){
　　    window.location.href="<?php echo $跳转; ?>";
　　    
　　};
　　
</script>
</body>
</html>
