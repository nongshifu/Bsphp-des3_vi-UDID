# 功能介绍-参数说明
### 远程功能都在BS后台-软件配置-软件描述设置
### 支持远程开启关闭 到期时间弹窗
1.到期时间弹窗:YES 每次启动App都弹到期时间
2.到期时间弹窗:NO 仅首次激活/到期/冻结/更新 才弹到期时间
### 支持IDFV UDID 两种模式绑定机器码
1. 验证udid还是idfv:YES  YES为UDID 获取描述文件 更新/刷机/还原 机器码不变
2. 验证udid还是idfv:NO  NO为idfv 更新/刷机/还原 机器码会变 不同app读取也不同
### 支持SCL弹窗过直播过录屏截图
过直播:YES  YES/NO 开启防录屏截图直播 仅支持SCL弹窗 iOS弹窗不支持
### 支持远程开启关闭试用功能 -新用户自动注册生成卡密
试用模式:YES YES/NO开启关闭试用功能 如开启 新用户获取机器码后查询数据库是否存在机器码最为依据 不存在就自动生成卡密 赠送时间=BS后台-软件配置-首次使用送 单位秒
### 支持远程SCL弹窗和IOS弹窗 
系统弹窗/SCL弹窗:YES  YES为iOS系统默认弹窗 NO 为SCL弹窗https://github.com/dogo/SCLAlertView
### 支持远程更新公告 
BS后台-修改公告-客户端会在心跳时间到就弹窗新公告- 心跳时间-Config.h #define  BS_DSQ 处
### 支持远程版本管理
验证版本更新:YES 当BS后台软件配置-版本-修改版本号 客户端会弹出更新 并且跳转URL 如果无需跳转 bs-软件配置-URL地址: 留空
### 支持远程发卡网弹窗
BS后台-软件配置-软件网页地址: 处 客户打开APP 在输入激活码界面会有购买按钮 跳转此处链接 如果不需要跳转 请留空 不显示购买按钮
### 支持远程锁定黑名单
BS后台-软件配置-用户分组 新建一个 黑名单分组 ,拉黑操作 BS后台-软件列表-用户 搜索对方卡密/机器码 编辑 移动到黑名单分组
 注意： 拉进黑名单分组 并未生效 必须同时在备注 那给客户留言 并且留言内容只是有个关键字"黑" 作为拉黑依据 比如：您已被拉黑
### 支持远程修改同卡密在线数量
BS后台-软件配置-限开控制-账号多开设: 注意这个为所有设备的总和 假如一个卡密 两个设备 每个设备2个app 那么在线数量写4 比如写3 只能两个设备里面三个app同时在线
### 支持远程修改卡密多开机器量
BS后台-软件配置-多开机器量: 机器码作为区分依据 比如设置1 设备A 激活了卡密 设备B也激活这个卡密 A上所有APP 将被迫下线不管同时在线写多少 只区分机器码
### 支持远程心态检测 被迫下线功能
源码Config.h 的#define  BS_DSQ 处 单位秒 既每个用户多少秒查询一次 冻结/到期/在线/多开/被迫下线/公告/版本更新等 用户多会增加服务器压力 量力而行 如10分钟检测一次
### 支持用户自主解绑-扣除时间远程控制
支持解绑:YES  YES/NO 开启和关闭 比如卡密abc 绑定了A设备 想换B设备 在B设备登录 会提示解绑按钮 扣除时间设置在 BS设置-软件配置-解绑定扣: 处 单位秒 
### 一个php文件 搞定UDID 试用 黑名单 解绑
udid.php 上传至BS站点目录下 可以是二级目录 修改里面的$签名=1 $数据库表前缀="bsphp_"
1.$签名 =2不签名,=1签名 如设置1,描述文件进行签名 需要一个SSL证书 放在udid.php同级目录,证书key保存为key.key 证书公匙保存为pem.pem,并且修改php设置
 如需签名宝塔为例-打开宝塔-软件商店-已安装 找到BS站点对应的php 设置-禁用函数 找到 shell_exec() 删除

### 完美兼容BSPHP最新版 开发定制联系:十三哥 WX:NongShiFu123  QQ:350722326

# 使用教程
### 1.将以下配置写到BS-软件描述

 到期时间弹窗:YES
 验证udid还是idfv:YES
 验证版本更新:YES
 过直播:NO
 系统弹窗/SCL弹窗:NO
 是否每次弹公告:YES
 试用模式:YES
 支持解绑:YES
 
### 只能改大写的YES/NO 也不要多换行 源码写死了关键字和顺序 YES/NO 说明看上面
<img width="589" alt="image" src="https://user-images.githubusercontent.com/31665489/226635657-ba759792-eb15-40a9-9cd4-004bd2684c05.png">

### 2.这里的接收和输出Sgin 必须大小的[KEY] 开头 不能留空 源码写死
<img width="517" alt="image" src="https://user-images.githubusercontent.com/31665489/226636903-345f65a0-e9fa-42d2-a77c-b53765f5efe7.png">

### 3.这里必须按这个配置
<img width="231" alt="image" src="https://user-images.githubusercontent.com/31665489/226637193-3d819073-6f76-46c1-bbff-77c1c6286bb9.png">

### 4.udid.php 上传至BS站点目录下-可以是二级目录 并且修改php里面$签名=1或者2 和$数据库表前缀
#### 签名=1 代表面描述文件签名,2不签名 如需签名 需要配置SSL证书 
<img width="415" alt="image" src="https://user-images.githubusercontent.com/31665489/226637942-48229744-2dd9-4bc4-8d60-537209aea6d2.png">

#### 将任意未到期的网站SSL证书 秘钥key保存到文本重命名为key.key 公匙pem保存文本重命名pem.pem
<img width="505" alt="image" src="https://user-images.githubusercontent.com/31665489/226639554-83eab2e5-72db-447f-a75d-da407486341a.png">

#### 将key.key pem.pem 放到udid.php同级目录 如果是二级目录 记得给777权限
重要 如果需要描述文件签名- BS站点对应的 PHP 禁用函数 删除shell_exec()
<img width="750" alt="image" src="https://user-images.githubusercontent.com/31665489/226641554-aa4d61c2-ccf5-4d27-af49-d55d0cc1bae3.png">

### 5.BS输出输入加密秘钥修改
源码里面Config.h里#define gIv 处 bs新安装默认是bsphp666 **注意 仅限8位数
<img width="976" alt="image" src="https://user-images.githubusercontent.com/31665489/226642176-99e62280-207e-47e0-98f1-72ef758e4420.png">

建议修改掉 在BS 站点目录/include/applibapi/encryption/ 下的bsphp_3des_vi.php 里 
<img width="455" alt="image" src="https://user-images.githubusercontent.com/31665489/226643022-0ce9011a-4faf-4880-a166-424cfca5ae72.png">

有3处 改成一样的 并且填写到Config.h 的#define gIv 处 建议修改 否则用bsphp666即可解析验证内容 等同于明文
Ctrl+F 搜索bsphp666 即可3处都改成一样的
<img width="570" alt="image" src="https://user-images.githubusercontent.com/31665489/226644212-13c886bc-50b7-4d8a-bd78-914a6f012121.png">


### 6. OK 生效就是在Config.h 傻瓜式搬运BS配置了


# 更新日志
##### 2023.03.21 删除shiyong.php 增加了拉黑功能,试用,解绑,功能集合到udid.php 并且自动识别目录 udid.php可上传任意目录
  优化了UDID逻辑 并且获取后自动删除udid缓存
  ***注意*** 黑名单功能 需要BS后台-软件列表-用户分组-新建一个黑名单分组
  ***拉黑用户说明：复制卡密-或者机器码 BS后台-软件列表-用户-搜索卡密/机器码-编辑 分组移动到黑名单分组 **并且填写一个备注 比如：你已经被拉黑-别玩了，用户那边提示你备注的信息
  *** 特别注意 备注 必须有一个 中文的"黑"字 用来判断是否是黑名单 正常用户备注 请勿出现关键字"黑" 否则被拉黑 并且用户那边提示你备注的信息
 
##### 2023.03.15 试用功能集合至软件描述处 优化跨进程注入桌面安全模式问题 arm64e<br>
##### 2023.03.11 添加了试用功能 如开启 BOOL 试用模式：YES 并且shiyong.php上传至服务器站点目录下 可以是二级目录 具体打开shiyong.php看注释说明,<br>
  试用开启 新设备获取机器码查询服务器记录 没就按BS软件配置-基础设置-首次使用送 处 赠送时间 卡密随机生成<br>
  ***注意*** 试用功能按机器码查询的 建议只在UDID模式下 试用 IDFA IDFV模式下刷机 升级 多开APP会变串码 存在变相无限试用风险<br>
 
##### 2023.03.09 全面弃用IDFA 支持多开控制 设备数量控制 在BS后台-软件配置-账号多开设 和 多开机器量设置 具体看使用说明的注意事项<br>

##### 2023.03.05 优化公告弹窗逻辑 增加了购买卡密识别 BS后台-软件网页地址处 留空则不会提示购买按钮<br>
##### 2023.03.02 吧卡密和UDID钥匙串储存 从新安装app或者多开直接读取无需重复输入卡密<br>
##### 2023.02.28 合并了两种UI弹窗 BS-软件描述-系统弹窗/SCL弹窗 处 YES=系统UI NO SCL弹窗<br>
##### 2023.02.25 优化了UDID获取页面逻辑 签名直接保存SSL证书key为key.key PEM证书储存为pem.pem 放在udid.php同级目录即可<br>
 
# 居于Bsphp官方源码 增加了UDID验证绑定
