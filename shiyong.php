<?php
/*试用说明
 1.将本文件上传至BSphp站点根目录下
 2.当Config.h中开启试用功能, 验证逻辑为>启动App>获取机器码>机器码调用本文件shiyong.php查询使用既然。 如存在机器码记录 折弹出输入验证码 没有记录则弹出 自定义激活码输入框 客户自己写个激活码进行验证
3.客户激活码试用时间在Bs软件后台-软件配置-基础配置-首次使用送  单位为秒 如试用三天259200秒输入即可
 *****注意**** idfv.idfa 模式下 多开app修改appid标识符 刷机 升级等 串码会变 相当于无限试用 谨慎 尽量在UDID 获取描述文件获取机器码情况下使用试用功能
 */

<?php
//插件说明，当前插件是单页面插件，不需要在url传输mac参数！
//固定头文件不用管
//2019.6.18
//引入单页文件
include ('/Plug/Plug.php');
$code=$_GET["code"];
$sql = "SELECT L_key_info FROM bsphp_pattern_login WHERE L_key_info = '$code'";
$info = plug_query_array($sql);
if (!$info) {
    $NEWode="没查到记录";
} else {
    $NEWode="有记录 |".$info['L_key_info'];
    //去卡密表查询
    
    
}
echo $NEWode;
?>

