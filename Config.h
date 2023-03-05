#import <Foundation/Foundation.h>

//服务器地址
#define  BSPHP_HOST  @"http://43.139.214.41:8088/AppEn.php?appid=61678765&m=2136d227b958807aa6d55f3a59e12ed5"
//通信认证Key
#define BSPHP_MUTUALKEY @"f85a13ab5cc1c2c4c5119a7315fbeee7"
//数据加密密码
#define BSPHP_PASSWORD @"mC7FzCc39ztHTWS0g7"
//接收Sgin验证 注意必须填写 并且有[KEY]
#define BSPHP_INSGIN @"[KEY]115336"
//输出Sgin验证 注意必须填写 并且有[KEY]
#define BSPHP_TOSGIN @"[KEY]115333"

//版本 和软件配置版本号一致 发布新版的时候 修改软件配置的版本号并且在URL那填写下载地址即可 客户端会弹出更新 确定会跳转浏览器下载
#define JN_VERSION @"0418"

//加密秘钥 这个在服务器文件后台 网站目录/include/applibapi/encryption下的bsphp_3des_vi.php 里面保持一致 搜索bsphp666就有3处地方都改掉 和这里源码一致
#define gIv   @"bsphp666"

//定期验证 单位为秒 可以设置10分钟 几分钟看个人需求 用于动态检测版本更新 公告更新 检测是否到期 检测是否冻结 时间太短 用户多会增加服务器压力
#define  BS_DSQ 600

//如果使用udid获取描述文件 需要udid.php上传到域名指定目录
#define  UDID_HOST  @"http://43.139.214.41:8088/udid/"

/*以下5个 参数 填写在BSPHP后台对应的软件设置-软件描述处 每个功能一个换行 切记 参数为BOOL 值 YES 或NO 大写 顺序不能错源码写死了
到期时间弹窗:YES
验证udid还是idfa:YES
验证版本更新:YES
过直播:YES
验证机器码是否是000:YES
系统弹窗/SCL弹窗:YES
公告弹窗:YES
 */

/*BS参数说明-详情可以看图片 说明.png
 到期时间弹窗:YES   设置YES每次启动都提示到期时间，设置NO 仅首次激活有提示 到期会有提示 正常使用期间不会提示
 验证udid还是idfa:YES  设置YES获取描述文件获取UDID ，设置NO 获取IDFA 无需描述文件
 验证版本更新:YES  设YES验证BS软件配置里面的版本号和上面JN_VERSION处是否一致 不一致就弹出URL 去浏览器下载同时app闪退 强制更新 弹出的URL更新地址在软件配置-URL地址 处 ，设置NO不验证
 过直播:YES  设置YES 弹窗就可以过直播 版本弹窗 时间到期弹窗 公告弹窗等 都能过录屏和截图 直播
 验证机器码是否是000:YES 设YES的话 上面第二个参数 验证udid还是idfa:NO 设置 为NO 仅对IDFA判断是否正常获取 系统设置-隐私-跟踪 没开启的话获取00000-
 系统弹窗/SCL弹窗:YES  YES使用系统弹窗 NO 使用SCL 弹窗
 公告弹窗:YES  YES 每次启动app 都会弹窗公告 NO 不弹公告
 
 
 更新日志======
 2023.03.05 优化公告弹窗逻辑 增加了购买卡密识别 BS后台-软件网页地址处 留空则不会提示购买按钮
 2023.03.02 吧卡密和UDID钥匙串储存 从新安装app或者多开直接读取无需重复输入卡密
 2023.02.28 合并了两种UI弹窗 BS-软件描述-系统弹窗/SCL弹窗 处 YES=系统UI NO SCL弹窗
 2023.02.25 优化了UDID获取页面逻辑 签名直接保存SSL证书key为key.key PEM证书储存为pem.pem 放在udid.php同级目录即可
 
 
 使用说明======
 1.将udid.php上传至服务器站点二级目录下 如站点 143.542.5.76 根目录的UDID目录下
 2.修改以上 #define  UDID_HOST 处为第一步骤的 站点ip或者域名+目录 如上步骤则 http://143.542.5.76/UDID/ 注意二级目录大小写
 3.编辑udid.php 里面的 $签名 处 和 $域名 处 即可 $域名 和上步骤一致  $签名=1表示 描述文件签名 2不签名 签名需要 到站点对应的php软件-设置-禁用函数-删除 shell_exec()函数
 4.将1.mobileprovision 上传至udid.php同级目录 1.mobileprovision必须是未掉签的企业证书描述文件 可以随便找个没掉签的企业证书描述文件
  个人证书的不行 如果掉签的 下载描述文件后就不能跳转自动iOS设置 需要手动打开 iOS设置
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
