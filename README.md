# 功能介绍
## 支持IDFV UDID 
## 支持远程开启关闭试用功能 -新用户自动注册生成卡密
## 支持远程SCL弹窗和IOS弹窗 
## 支持远程更新公告 
## 支持远程版本管理
## 支持远程发卡网弹窗
## 支持远程锁定黑名单
## 支持远程修改同卡密在线数量
## 支持远程修改卡密多开机器量
## 支持远程心态检测 被迫下线功能
## 支持用户自主解绑-扣除时间远程控制
## 一个php文件 搞定UDID 试用 黑名单 解绑
## 完美兼容BSPHP最新版 开发定制联系:十三哥 WX:NongShiFu123  QQ:350722326

# 更新日志
2023.03.21 删除shiyong.php 增加了拉黑功能,试用,解绑,功能集合到udid.php 并且自动识别目录 udid.php可上传任意目录
  优化了UDID逻辑 并且获取后自动删除udid缓存
  ******注意 黑名单功能 需要BS后台-软件列表-用户分组-新建一个黑名单分组
  ***拉黑用户说明：复制卡密-或者机器码 BS后台-软件列表-用户-搜索卡密/机器码-编辑 分组移动到黑名单分组 **并且填写一个备注 比如：你已经被拉黑-别玩了，用户那边提示你备注的信息
  *** 特别注意 备注 必须有一个 中文的"黑"字 用来判断是否是黑名单 正常用户备注 请勿出现关键字"黑" 否则被拉黑 并且用户那边提示你备注的信息
 
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

