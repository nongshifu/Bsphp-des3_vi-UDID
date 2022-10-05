//#import <AFNetworkReachabilityManager.h>
//#import "QQ6209940.h"
////  #import "DLGMemEntry.h"
//#import "DLGMem.h"
//#import "LRKeychain.h"
//#import <WebKit/WebKit.h>
//#import <UIKit/UIKit.h>
//#import <objc/runtime.h>
//#import <dlfcn.h>
//#import <mach-o/dyld.h>
//#import <AVFoundation/AVFoundation.h>
//#import <AdSupport/ASIdentifierManager.h>
//#import "SCLAlertView.h"
//#import "defines.h"
//#import <Foundation/Foundation.h>
//#import "MF_Base64Additions.h"
//#import "NSDictionary+StichingStringkeyValue.h"
//#import "NSString+MD5.h"
//#import "NSString+URLCode.h"
//#import "UserInfoManager.h"
//#import "Config.h"
//#import "UIAlertView+Blocks.h"
//@interface VerifyEntry ()<UIAlertViewDelegate>
//@end
//@implementation QQ6209940
//
//
//- (void)FWLT{
//    
//    //1.创建网络状态监测管理者
//    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//    //开启监听，记得开启，不然不走block
//    [manger startMonitoring];
//    //2.监听改变
//    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        //AFNetworkReachabilityStatusUnknown          = -1,
//        //AFNetworkReachabilityStatusNotReachable     = 0,
//        //AFNetworkReachabilityStatusReachableViaWWAN = 1,
//        2;          //AFNetworkReachabilityStatusReachableViaWiFi = 2,
//        
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"未知");
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络");
//                exit(0);
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"3G|4G");
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"WiFi");
//                break;
//            default:
//                break;
//        }
//    }];
//    
//    
//    
//}
//
//
//
//- (BOOL)VPNtishitiao{
//    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
//    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
//    NSLog(@"\n%@",proxies);
//    
//    NSDictionary *settings = proxies[0];
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
//    
//    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
//    {
//        NSLog(@"未检测到代理");
//        return NO;
//    }
//    else
//    {
//        //  [self showMessage:[NSString stringWithFormat:@"检测到您开启了vpn,请关闭..."] duration:3];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检测到您开启了vpn,请关闭..." message:nil preferredStyle:UIAlertControllerStyleAlert];
//        [[[[UIApplication sharedApplication].delegate window] rootViewController] presentViewController:alertController animated:YES completion:^{
//            
//        }];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            exit(0);
//        });
//        NSLog(@"检测到代理");
//        return YES;
//    }
//}
//bool 成功= NO;
//
////在验证处开启VPN检测、直接给予闪退
//- (BOOL)VPNzhijiesantui{
//    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
//    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
//    NSLog(@"\n%@",proxies);
//    
//    NSDictionary *settings = proxies[0];
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
//    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
//    
//    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
//    {
//        NSLog(@"未检测到代理");
//        return NO;
//    }
//    else
//    {
//        exit(0);
//        
//        return YES;
//    }
//}
//
//-(void)Bsphp{
//    NSLog(@"=====----===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"data"]);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self FWLT];
//        [self VPNtishitiao];
//        if([[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"] != nil)
//        {
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            param[@"api"] = @"login.ic";
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
//            NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
//            param[@"BSphpSeSsL"] = [dateStr MD5Digest];
//            NSDate *date = [NSDate date];
//            NSTimeZone * zone = [NSTimeZone systemTimeZone];
//            NSInteger interval = [zone secondsFromGMTForDate:date];
//            NSDate * nowDate = [date dateByAddingTimeInterval:interval];
//            NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
//            param[@"date"] = nowDateStr;
//            param[@"md5"] = @"";
//            param[@"mutualkey"] = BSPHP_MUTUALKEY;
//            param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"];
//            param[@"icpwd"] = @"";
//            param[@"key"] = [[VerifyEntry MySharedInstance] getIDFA];
//            param[@"maxoror"] = [[VerifyEntry MySharedInstance] getIDFA];
//            [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject)
//             {
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                                     options:NSJSONReadingMutableContainers
//                                                                       error:nil];
//                if(!dict){
//                    exit(0);//没数据 直接闪退 不用复制机器码码
//                }else
//                {
//                    NSString *dataString = dict[@"response"][@"data"];
//                    NSRange range = [dataString rangeOfString:@"|1081|"];
//                    [[NSUserDefaults standardUserDefaults] setObject:dataString forKey:@"data"];
//                    if (strstr(dataString.UTF8String,"|1081|"))
//                    {
//                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
//                        NSArray *arr = [dataString componentsSeparatedByString:@"|"];
//                        if (arr.count >= 6 && dataString.length>12)
//                        {
//                            manager.state01 = arr[0];
//                            manager.state1081 = arr[1];
//                            manager.deviceID = arr[2];//设备码
//                            manager.returnData = arr[3];
//                            manager.expirationTime = arr[4];
//                            
//                            manager.activationTime = arr[5];
//                            
//                            DisPatchGetMainQueueBegin();
//                            成功 = YES;
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证成功" message:arr[4] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                            [alert show];
//                            [self XLGGBB];
//                            
//                            
//                            
//                            
//                            
//                            
//                            
//                            NSString* bbbbbb=[NSString stringWithFormat:@" %@", arr[4]];
//                            
//                            if ([bbbbbb containsString:@"9999"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            if ([bbbbbb containsString:@"隔壁老王出品 By:BOSS王爷"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            if ([bbbbbb containsString:@"隔壁老王破解永久"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            if ([bbbbbb containsString:@"Shadow"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            if ([bbbbbb containsString:@"王爷"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            if ([bbbbbb containsString:@"破解"]) {
//                                
//                                NSLog(@"过期时间 包含 null被破解闪退");
//                                exit(0);
//                            }
//                            
//                            if (bbbbbb.length<5) {
//                                exit(0);
//                                
//                                NSLog(@"过期时间长度小于5 闪退");
//                                exit(0);
//                                
//                                
//                                
//                            }
//                            
//                            
//                            
//                            
//                            DisPatchGetMainQueueEnd();
//                            
//                        }else{
//                            [[VerifyEntry MySharedInstance] processActivate];
//                        }
//                        
//                    }
//                    else
//                    {
//                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
//                        manager.state01 = nil;
//                        manager.state1081 = nil;
//                        manager.deviceID = nil;
//                        manager.returnData = nil;
//                        manager.expirationTime = nil;
//                        manager.activationTime = nil;
//                        //验证时间
//                        [[VerifyEntry MySharedInstance] processActivate];
//                    }
//                }
//            } myfailure:^(NSError *error)
//             {
//                [[VerifyEntry MySharedInstance] processActivate];
//            }];
//        }
//        else
//        {
//            [[VerifyEntry MySharedInstance] processActivate];
//        }
//        
//    });
//}
//- (void)dismiss:(UIAlertController *)alertController{
//    [alertController dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//
//
//
//
//
//
//#pragma mark  提示条
//- (void)XLGGBB{
//    //版本号检测和公告
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *_ = @"v.in";
//        NSString * XLBB1 =BSBB;
//        NSString * XLHOST = BSPHP_HOST ;
//        
//        NSString * XLKEY = BSPHP_MUTUALKEY;
//        NSDate *currentDate = [NSDate date];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        NSString *appsafecode = [dateFormatter stringFromDate:currentDate];
//        param[@"api"] =_;
//        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
//        param[@"BSphpSeSsL"] = [dateStr MD5Digest];
//        param[@"date"] = [dateFormatter stringFromDate:currentDate];
//        param[@"appsafecode"] = appsafecode;
//        param[@"mutualkey"] = XLKEY;
//        [NetTool Post_AppendURL:XLHOST myparameters:param mysuccess:^(id responseObject) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if(!dict) {
//                exit(-1);//没有数据 直接闪退
//            }
//            if (dict) {
//                if(![dict[@"response"][@"appsafecode"] isEqualToString:appsafecode]){
//                    exit(-1);//被劫持了 直接闪退
//                }
//            }
//            if (![dict[@"response"][@"data"] isEqualToString:XLBB1]) {//获取bsphp版本号
//                [self MsgX:dict[@"response"][@"data"] TitleX:@"有新的可更新版本" confirmTitle:@"前往更新" confirmHandle:^{
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:gxdz] options:@{} completionHandler:nil];
//                }];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    exit(-1);
//                });
//                
//                
//            } else {
//                
//                NSString *appsafecode = [dateFormatter stringFromDate:currentDate];
//                param[@"api"] = @"gg.in";
//                param[@"date"] = [dateFormatter stringFromDate:currentDate];
//                param[@"appsafecode"] = appsafecode;
//                [NetTool Post_AppendURL:XLHOST myparameters:param mysuccess:^(id responseObject) {
//                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                    if(!dict) {
//                        exit(0);//没有数据 直接闪退
//                    }
//                    if (dict) {
//                        if(![dict[@"response"][@"appsafecode"] isEqualToString:appsafecode]){
//                            exit(0);//被劫持了 直接闪退
//                        }
//                    }
//                    NSString * re_data = [dict[@"response"][@"data"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r"];
//                    
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"阿尔法公告" message:re_data  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                    
//                } myfailure:^(NSError *error) {
//                    exit(0);
//                }];
//            }
//            
//        } myfailure:^(NSError *error) {
//            exit(0);
//        }];
//    });
//}
//
//
//
//- (void)MsgX:(NSString *)message TitleX:(NSString *)TitleX confirmTitle:(NSString *)confirmTitle confirmHandle:(void(^)(void))handle {
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.windowLevel = UIWindowLevelAlert;
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = [UIColor clearColor];
//    window.rootViewController = vc;
//    [window makeKeyAndVisible];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TitleX message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (handle) {
//            handle();
//        }
//        window.hidden = YES;
//    }]];
//    [vc presentViewController:alertController animated:YES completion:nil];
//}
//@end
//@implementation VerifyEntry
//-(void)dingshi{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString*po=[[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
//        if ([po containsString:@"不"]) {
//            NSLog(@"=====----===%@",po);
//            //  exit(0);//
//            exit(0); //processActivate];
//        }
//    });
//    
//}
//+ (instancetype)MySharedInstance
//{
//    static VerifyEntry *sharedSingleton;
//    
//    if (!sharedSingleton)
//    {
//        static dispatch_once_t oncePPM;
//        dispatch_once(&oncePPM, ^
//                      {
//            sharedSingleton = [[VerifyEntry alloc] init];
//        });
//    }
//    
//    return sharedSingleton;
//}
//
//
//- (NSString*)getIDFA
//{
//    ASIdentifierManager *as = [ASIdentifierManager sharedManager];
//    return as.advertisingIdentifier.UUIDString;
//}
//
//- (void)showAlertMsg:(NSString *)show error:(BOOL)error
//{
//    
//    DisPatchGetMainQueueBegin();
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:show delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    
//    
//    
//    DisPatchGetMainQueueEnd();
//}
//
//- (void)startProcessActivateProcess:(NSString *)code finish:(void (^)(NSDictionary *done))finish
//{
//    //授权码验证
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"api"] = @"login.ic";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
//    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
//    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
//    NSDate *date = [NSDate date];
//    NSTimeZone * zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
//    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
//    param[@"date"] = nowDateStr;
//    param[@"md5"] = @"";
//    param[@"mutualkey"] = BSPHP_MUTUALKEY;
//    param[@"icid"] = code;
//    param[@"icpwd"] = @"";
//    param[@"key"] = [self getIDFA];
//    param[@"maxoror"] = [self getIDFA];
//    [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject)
//     {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if(!dict){
//            exit(0);//没数据 直接闪退 不用复制机器码码
//        }
//        if (dict)
//        {
//            NSString *dataString = dict[@"response"][@"data"];
//            NSRange range = [dataString rangeOfString:@"|1081|"];
//            if(![dataString containsString:[self getIDFA]]){
//                [self showAlertMsg:@"授权失败,请购买授权码" error:YES];
//                [self processActivate];
//            }
//            else if (range.location != NSNotFound)
//            {
//                NSString *activationDID = [[NSUserDefaults standardUserDefaults]objectForKey:@"activationDeviceID"];
//                if (![activationDID isEqualToString:code])
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"activationDeviceID"];
//                }
//                
//                UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
//                NSArray *arr = [dataString componentsSeparatedByString:@"|"];
//                if (arr.count >= 6)
//                {
//                    manager.state01 = arr[0];
//                    manager.state1081 = arr[1];
//                    manager.deviceID = arr[2];
//                    manager.returnData = arr[3];
//                    manager.expirationTime = arr[4];
//                    manager.activationTime = arr[5];
//                    
//                    DisPatchGetMainQueueBegin();
//                    
//                    
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"激活成功请重启游戏" message:nil
//                                                                                      preferredStyle:UIAlertControllerStyleAlert];
//                    [[[[UIApplication sharedApplication].delegate window] rootViewController] presentViewController:alertController animated:YES completion:^{
//                        [self performSelector:@selector(dismiss:) withObject:alertController afterDelay:10000000000000.0];
//                    }];
//                    
//                    DisPatchGetMainQueueEnd();
//                }
//            }
//            else
//            {
//                NSString *messageStr = dict[@"response"][@"data"];
//                UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
//                manager.state01 = nil;
//                manager.state1081 = nil;
//                manager.deviceID = nil;
//                manager.returnData = nil;
//                manager.expirationTime = nil;
//                manager.activationTime = nil;
//                [self showAlertMsg:messageStr error:YES];
//                [self processActivate];
//            }
//        }
//    } myfailure:^(NSError *error)
//     {
//        [self processActivate];
//    }];
//    [self dingshi];
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSString *CONFIRM = @"激活";
//    
//    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
//    if (YES == [btnTitle isEqualToString:CONFIRM])
//    {
//        UITextField *tf = [alertView textFieldAtIndex:0];
//        if (nil == tf.text || 0 == tf.text.length)
//        {
//            [self processActivate];
//            return ;
//        }
//        
//        [self startProcessActivateProcess:tf.text finish:nil];
//    }
//    else
//    {
//        [self processActivate];
//    }
//    
//}
//
//
//
//- (void)processActivate
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (![UserInfoManager shareUserInfoManager].deviceID) {
//                exit(0);
//            }
//        });
//    });
//    
//    NSString *CONFIRM = @"激活";
//    
//    NSString *CANCEL = @"取消";
//    
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请在5秒内激活否则闪退" delegate:self cancelButtonTitle:CANCEL otherButtonTitles:CONFIRM, nil];
//    
//    
//    
//    
//    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    UITextField *txtName = [alert textFieldAtIndex:0];
//    txtName.placeholder = @"";
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    txtName.text =pasteboard.string;
//    [alert show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        exit(0);});
//    
//    
//    
//}
//
//
//@end
//
//
//
//
//
//
