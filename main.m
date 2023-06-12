#import "WX_NongShiFu123.h"
#import "getKeychain.h"
@implementation NSObject (mian)
+(void)load
{
    //测试的时候 可以取消注释 启动一次便可清除
//    [getKeychain removeKeychainDataForKey:@"DZUDID"];//清除UDID
//    [getKeychain removeKeychainDataForKey:@"SJUSERID"];//清除用户ID
//    [getKeychain removeKeychainDataForKey:@"ShiSanGeDZKM"];//清除卡密
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"公告"];//清除公告
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"到期时间"];//清除到期时间

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WX_NongShiFu123 alloc] BSPHP];
    });
}
@end
