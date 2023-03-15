# 更新日志
 2023.03.15 试用功能集合至软件描述处 优化跨进程注入桌面安全模式问题 arm64e<br>
 2023.03.11 添加了试用功能 如开启 BOOL 试用模式：YES 并且shiyong.php上传至服务器站点目录下 可以是二级目录 具体打开shiyong.php看注释说明,<br>
  试用开启 新设备获取机器码查询服务器记录 没就按BS软件配置-基础设置-首次使用送 处 赠送时间 卡密随机生成<br>
  ******注意 试用功能按机器码查询的 建议只在UDID模式下 试用 IDFA IDFV模式下刷机 升级 多开APP会变串码 存在变相无限试用风险<br>
 
 2023.03.09 全面弃用IDFA 支持多开控制 设备数量控制 在BS后台-软件配置-账号多开设 和 多开机器量设置 具体看使用说明的注意事项<br>

 2023.03.05 优化公告弹窗逻辑 增加了购买卡密识别 BS后台-软件网页地址处 留空则不会提示购买按钮<br>
 2023.03.02 吧卡密和UDID钥匙串储存 从新安装app或者多开直接读取无需重复输入卡密<br>
 2023.02.28 合并了两种UI弹窗 BS-软件描述-系统弹窗/SCL弹窗 处 YES=系统UI NO SCL弹窗<br>
 2023.02.25 优化了UDID获取页面逻辑 签名直接保存SSL证书key为key.key PEM证书储存为pem.pem 放在udid.php同级目录即可<br>
 
# 居于Bsphp官方源码 增加了UDID验证绑定
## 这里是几个基本配置 顺序不能错 大写的YES/NO  注意换行
<img width="654" alt="image" src="https://user-images.githubusercontent.com/31665489/225242648-34ad372d-e06f-4220-8426-f599ba04ff71.png">
## 这里是发布新版的下载地址 源码更新版本号 旧客户端会提示更新 点击更新会跳转这个地址
<img width="702" alt="image" src="https://user-images.githubusercontent.com/31665489/190995465-477e9e49-f9a8-46e9-8290-b07899f4f6d6.png">
## 这里软件发卡地址 在激活页面 会有购买按钮 留空就不会出现购买按钮 
<img width="631" alt="image" src="https://user-images.githubusercontent.com/31665489/225242993-c718286d-7cf4-4ab3-b4d5-a75b38ec5fac.png">

## 这里是软件设置 注意签名那一定要有[KEY] 大写
<img width="541" alt="image" src="https://user-images.githubusercontent.com/31665489/190995529-7e649873-831b-4944-a307-d986b3d4289c.png">

##加密配置
<img width="651" alt="image" src="https://user-images.githubusercontent.com/31665489/190995617-b684fcea-bb2f-4246-b568-99633c6344aa.png">

## 修改BSPHP 的des3加密秘钥 默认是bsphp666 里面有三处都要修改 和源码Config.h里面#define gIv 一致
<img width="1083" alt="image" src="https://user-images.githubusercontent.com/31665489/190995838-fe2bd5bc-9953-4ac2-b0ff-ca786462ab1c.png">
<img width="887" alt="image" src="https://user-images.githubusercontent.com/31665489/190996768-bc81aa07-e05b-4fd4-97ea-97d2e3712f95.png">
## 由于每个app 都会生成一个描述文件 和udid文件 久了就产生缓存文件过多 可以在服务器后台 如宝塔 计划任务 设置各shell脚本 每天清理
注意这里改成你的udid目录 
<img width="904" alt="image" src="https://user-images.githubusercontent.com/31665489/195619823-94d60047-1686-4145-956d-c09b154db05b.png">

cd /www/wwwroot/myradar.cn/UDID

find . -name '*.txt' -maxdepth 1 -type f -print -exec rm -rf {} \;

find . -name '*.mobileconfig' -maxdepth 1 -type f -print -exec rm -rf {} \;

