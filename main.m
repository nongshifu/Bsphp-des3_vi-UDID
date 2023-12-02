//  BSPHPOC
//  BSPHP 魔改UDID 技术团队 十三哥工作室
//  承接软件APP开发 UDID定制 验证加密二改 PHP JS HTML5开发 辅助开发
//  WX:NongShiFu123 QQ350722326
//  Created by MRW on 2022/11/14.
//  GitHub:http://github.com/nongshifu/
//  开源Q群: 398423911
//  Copyright © 2019年 xiaozhou. All rights reserved.
//com.rileytestut.Delta.Beta
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
