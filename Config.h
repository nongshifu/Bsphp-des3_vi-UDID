#import <Foundation/Foundation.h>

//服务器地址
#define  BSPHP_HOST  @"https://myradar.cn/AppEn.php?appid=467645342&m=9e8ac707e317651e741a5131be49df7d"
//通信认证Key
#define BSPHP_MUTUALKEY @"7c316f815214a1f86a18e62394528414"
//接收Sgin验证 注意必须填写 并且有[KEY]
#define BSPHP_INSGIN @"[KEY]RHHGFGSNGRG"
//输出Sgin验证 注意必须填写 并且有[KEY]
#define BSPHP_TOSGIN @"[KEY]RHHGFGSNGRG"
//数据加密密码
#define BSPHP_PASSWORD @"6IrQ34YSce9hrFb2X1"

//版本 和软件配置版本号一致 发布新版的时候 修改软件配置的版本号并且在URL那填写下载地址即可 客户端会弹出更新 确定会跳转浏览器下载
#define JN_VERSION @"2.0"

//加密秘钥 这个在服务器文件后台 网站目录/include/applibapi/encryption下的bsphp_3des_vi.php 里面保持一致 搜索bsphp666就有3处地方都改掉 和这里源码一致 BS安装默认为bsphp666
#define gIv   @"Asd7480547"

//定期验证 单位为秒 可以设置10分钟 几分钟看个人需求 用于动态检测版本更新 公告更新 检测是否到期 检测是否冻结 时间太短 用户多会增加服务器压力
#define  BS_DSQ 2

//如果使用udid获取描述文件 需要udid.php上传到域名指定目录
#define  UDID_HOST  @"https://myradar.cn/UDID/"

//启动APP后多少秒开始验证 单位秒 ** 因为很多游戏有启动画面 启动动画 会刷新UI 刷掉弹窗 相当于没了验证 比如光遇 王者荣耀 等 要等启动动画结束才弹窗 自己测试时间
#define BS延迟启动时间 0

//是否启用试用功能 YES NO
BOOL 试用模式=NO;
//试用查询地址目录 具体看shiyong.php 上传的位置 看里面的注释解释
#define  shiyongURL  @"https://myradar.cn/shiyong.php"

/*以下5个 参数 填写在BSPHP后台对应的软件设置-软件描述处 每个功能一个换行 切记 参数为BOOL 值 YES 或NO 大写 顺序不能错源码写死了
 到期时间弹窗:YES
 验证udid还是idfa:YES
 验证版本更新:YES
 过直播:NO
 系统弹窗/SCL弹窗:NO
 是否每次弹公告:YES
 */

/*BS参数说明-详情可以看图片 说明.png
 到期时间弹窗:YES   设置YES每次启动都提示到期时间，设置NO 仅首次激活有提示 到期会有提示 正常使用期间不会提示
 验证udid还是idfa:YES  设置YES获取描述文件获取UDID ，设置NO 获取IDFA 无需描述文件
 验证版本更新:YES  设YES验证BS软件配置里面的版本号和上面JN_VERSION处是否一致 不一致就弹出URL 去浏览器下载同时app闪退 强制更新 弹出的URL更新地址在软件配置-URL地址 处 ，设置NO不验证
 过直播:YES  设置YES 弹窗就可以过直播 版本弹窗 时间到期弹窗 公告弹窗等 都能过录屏和截图 直播
 系统弹窗/SCL弹窗:YES  YES使用系统弹窗 NO 使用SCL 弹窗
 是否每次弹公告:YES  YES 每次启动app 都会弹窗公告 NO 不弹公告 除非 公告发生在线更新
 
 
 更新日志======
 
 2023.03.11 添加了试用功能 如开启 BOOL 试用模式=YES 并且shiyong.php上传至服务器站点目录下 可以是二级目录 具体打开shiyong.php看注释说明,
  试用开启 新设备获取机器码查询服务器记录 没就按BS软件配置-基础设置-首次使用送 处 赠送时间 卡密随机生成
  ******注意 试用功能按机器码查询的 建议只在UDID模式下 试用 IDFA IDFV模式下刷机 升级 多开APP会变串码 存在变相无限试用风险
 
 2023.03.09 全面弃用IDFA 支持多开控制 设备数量控制 在BS后台-软件配置-账号多开设 和 多开机器量设置 具体看使用说明的注意事项

 2023.03.05 优化公告弹窗逻辑 增加了购买卡密识别 BS后台-软件网页地址处 留空则不会提示购买按钮
 2023.03.02 吧卡密和UDID钥匙串储存 从新安装app或者多开直接读取无需重复输入卡密
 2023.02.28 合并了两种UI弹窗 BS-软件描述-系统弹窗/SCL弹窗 处 YES=系统UI NO SCL弹窗
 2023.02.25 优化了UDID获取页面逻辑 签名直接保存SSL证书key为key.key PEM证书储存为pem.pem 放在udid.php同级目录即可
 
 
 使用说明===============
 1.将udid.php上传至服务器站点二级目录下 如站点 143.542.5.76 根目录的UDID目录下
 2.修改以上 #define  UDID_HOST 处为第一步骤的 站点ip或者域名+目录 如上步骤则 http://143.542.5.76/UDID/ 注意二级目录大小写
 3.编辑udid.php 里面的 $签名 处 和 $域名 处 即可 $域名 和上步骤一致  $签名=1表示 描述文件签名 2不签名 签名需要 到站点对应的php软件-设置-禁用函数-删除 shell_exec()函数
 4.将1.mobileprovision 上传至udid.php同级目录 1.mobileprovision必须是未掉签的企业证书描述文件 可以随便找个没掉签的企业证书描述文件
  个人证书的不行 如果掉签的 下载描述文件后就不能跳转自动iOS设置 需要手动打开 iOS设置
 
 **多开设置**注意 账号多开数量为全部设备在线APP总和
 举例 情况1 :多开机器量设置为2 账号多开设2 那么同一个卡密在设备A登录 然后在设备B登录 也可以使用 但是1个设备只能1个App AB任意设备打开第三个 第一个App就退出 总之两个设备打开的APP不超过2
 
 举例 情况2：多开机器量设置为2 账号多开设1 那么同一个卡密在设备A登录 然后在设备B登录 也可以使用 但是设备A会被迫下线 反之如果重启设备A 则B又被破下线 虽然多开机器设置为2 但是多开总量为1
 举例 模式3：多开机器量设置为1或者-1(即关闭)默认只能1台设备 多开设置为5 那么设备A 上同一个卡密 最多可以激活码5个App 启动第六个激活 那么第一个被迫退出 , 换另一个设备B 同一个卡密登录 A设备所有APP退出

 *** 推荐 大多情况下 验证系统目的是为了绑定设备 因此多开机器量设置为-1 关闭 然后软件 设置-是否绑定模式:验证绑定特征 这样防止卡密倒卖 在A设备激活绑定后 无法在设备B激活
 *** 因为如果 设置-是否绑定模式:免验证绑定特征 那么即使多开设为1 多开设备也为1 但是可以错开时间使用 比如早上小学生A在A设备玩 下午B小学生在B设备玩 因为错开 不会被迫下线
 */



@interface NetTool : NSObject

/**
 *  AFN异步发送post请求，返回原生数据
 *
 *  @param appendURL 追加URL
 *  @param param     参数字典
 *  @param success   成功Block
 *  @param failure   失败Block
 *
 *  @return NSURLSessionDataTask任务类型
 */
+ (NSURLSessionDataTask *)__attribute__((optnone))Post_AppendURL:(NSString *)appendURL parameters:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
