//
//  ViewController.m
//  BSPHPOC
//  BSPHP 魔改UDID 技术团队 十三哥工作室
//  承接软件APP开发 UDID定制 验证加密二改 PHP JS HTML5开发 辅助开发
//  WX:NongShiFu123 QQ350722326
//  Created by MRW on 2022/11/14.
//  Copyright © 2019年 xiaozhou. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import "Config.h"
#import "WX_NongShiFu123.h"
#import <UIKit/UIKit.h>
#import "getKeychain.h"
#import "Config.h"
#import "SCLAlertView.h"
#import "MBProgressHUD+NJ.h"
#import <dlfcn.h>
#include <stdio.h>
#import <string.h>

#import <AdSupport/ASIdentifierManager.h>
@interface WX_NongShiFu123 ()
@property (nonatomic,strong) NSDictionary * baseDict;
@end
NSString*软件版本号,*软件公告,*软件描述,*软件网页地址,*软件url地址,*逻辑A,*逻辑B,*解绑扣除时间,*试用模式,*支持解绑;;
bool 验证状态,过直播开关,是否新用户;
NSString*设备特征码;
NSString*软件信息;
static NSTimer*dsq;
@implementation WX_NongShiFu123

/*
 逻辑
 1.启动APP
 2.取getBSphpSeSsL
 3.读取描述 判断哪种 机器码方式UDID/IDFV 读取 弹窗类型 版本 公告 开关
 4.开始验证
 5.定时读取登录状态 -并且读取版本更新-公告更新
 */

+ (void)load {
}

#pragma mark --- 验证流程
NSString* 到期时间弹窗,*UDID_IDFV,*验证版本,*验证过直播,*弹窗类型,*验证公告,*到期时间;
- (void)BSPHP{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(BS延迟启动时间 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL NET=[self getNet];
        if (!NET) {
            
            [self showText:@"警告" message:@"网络连接失败" Exit:NO];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [self getBSphpSeSsL:^{
                    [self getXinxi:^{
                        if ([UDID_IDFV containsString:@"YES"]) {
                            [self getUDID:^{
                                [self shiyong:^{
                                    [self YZTC:@"请输入激活码"];
                                }];
                            }];
                        }else{
                            [self getIDFV:^{
                                [self shiyong:^{
                                    [self YZTC:@"请输入激活码"];
                                }];
                            }];
                            
                        }
                        
                        
                    }];
                    
                }];
            });
        }
    });
    
    
}
#pragma mark --- 网络状态
- (BOOL)getNet {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    BOOL isReachable = success && (flags & kSCNetworkFlagsReachable);
    BOOL needsConnection = success && (flags & kSCNetworkFlagsConnectionRequired);
    BOOL canConnectAutomatically = success && (flags & kSCNetworkFlagsConnectionAutomatic);
    BOOL canConnectWithoutUserInteraction = canConnectAutomatically && !(flags & kSCNetworkFlagsInterventionRequired);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    CFRelease(reachability);
    
    if (isNetworkReachable) {
        MyLog(@"网络可用");
        return YES;
    } else {
        MyLog(@"网络不可用");
        return NO;
    }
    return NO;
}



#pragma mark --- 验证弹窗
- (void)YZTC:(NSString*_Nullable)string
{
    MyLog(@"激活码弹窗");
    NSString*km=[getKeychain getKeychainDataForKey:@"ShiSanGeDZKM"];
    if (km.length>2) {
        MyLog(@"激活码弹窗KM=%@",km);
        [self yanzhengAndUseIt:km];
    }else{
        
        if ([弹窗类型 containsString:@"YES"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //系统弹窗
                UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                WX_NongShiFu123 *alert = [WX_NongShiFu123 alertControllerWithTitle:nil message:string preferredStyle:UIAlertControllerStyleAlert];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"请输入激活码";
                    textField.secureTextEntry = NO;
                    textField.borderStyle = UITextBorderStyleRoundedRect;
                    textField.clearButtonMode = UITextFieldViewModeAlways;
                    textField.layer.masksToBounds=YES;
                }];
                UIAlertAction *cancelAction;
                if (软件网页地址.length>5) {
                    cancelAction = [UIAlertAction actionWithTitle:@"购买" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:软件网页地址] options:@{} completionHandler:^(BOOL success) {
                            exit(0);
                        }];
                    }];
                }else{
                    cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        // 取消操作
                        exit(0);
                    }];
                }
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 确定操作
                    UITextField *textField1 = alert.textFields.firstObject;
                    MyLog(@"输入框1：%@", textField1.text);
                    if (textField1.text.length ==0 ) {
                        MyLog(@"输入框内容为空");
                        // 输入框内容为空，做出相应提示或处理
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self YZTC:@"输入内容为空"];
                        });
                    }else{
                        [self yanzhengAndUseIt:textField1.text];
                    }
                    
                }];
                
                [alert addAction:cancelAction];
                [alert addAction:okAction];
                
                [rootViewController presentViewController:alert animated:YES completion:nil];
            });
            
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //SCL弹窗
                SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor=[UIColor systemGreenColor];
                alert.shouldDismissOnTapOutside = NO;
                SCLTextView *textF =   [alert addTextField:@"请在30秒内填写授权码"setDefaultText:nil];
                [alert addButton:@"粘贴" validationBlock:^BOOL{
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    textF.text =pasteboard.string;
                    return NO;
                }actionBlock:^{}];
                if (软件网页地址.length>5) {
                    [alert addButton:@"购买" actionBlock:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:软件网页地址] options:@{} completionHandler:nil];
                    }];
                }
                
                [alert alertDismissAnimationIsCompleted:^{
                    if (textF.text.length==0) {
                        [self YZTC:@"请输入激活码"];
                    }else{
                        [self yanzhengAndUseIt:textF.text];
                    }
                }];
                [alert showEdit:@"授权" subTitle:string closeButtonTitle:@"授权" duration:0];
            });
            
            
        }
    }
    
}

#pragma mark ---获取本次打开的BSphpSeSsL 作为在线判断

- (void)getBSphpSeSsL:(void (^)(void))completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] = @"BSphpSeSsL.in";
    param[@"date"] = [self getSystemDate];
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            self.baseDict = dict;
            // 调用回调函数
            if (completion) {
                completion();
            }
        }
    } failure:^(NSError *error) {
        MyLog(@"BSphpSeSsL获取失败=%@",error);
    }];
    
}


#pragma mark ---软件信息

- (void)getXinxi:(void (^)(void))completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"globalinfo.in";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];
    param[@"date"] = [self getSystemDate];
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    param[@"md5"] = @"";
    param[@"info"] = @"GLOBAL_V|GLOBAL_GG|GLOBAL_MIAOSHU|GLOBAL_WEBURL|GLOBAL_URL|GLOBAL_LOGICINFOA|GLOBAL_LOGICB|GLOBAL_TURN";
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            软件信息=dict[@"response"][@"data"];
            MyLog(@"软件信息=%@",软件信息);
            NSArray *arr = [软件信息 componentsSeparatedByString:@"|"];
            软件版本号=arr[0];
            软件公告=arr[1];
            软件描述=arr[2];
            软件网页地址=arr[3];
            软件url地址=arr[4];
            逻辑A=arr[5];
            逻辑B=arr[6];
            解绑扣除时间=arr[7];
            NSArray *arr2 = [软件描述 componentsSeparatedByString:@"\n"];
            到期时间弹窗=arr2[0];
            UDID_IDFV=arr2[1];
            验证版本=arr2[2];
            验证过直播=arr2[3];
            弹窗类型=arr2[4];
            验证公告=arr2[5];
            试用模式=arr2[6];
            支持解绑=arr2[7];
            if ([验证过直播 containsString:@"YES"]) {
                过直播开关=YES;
            }
            [self getVV:^{
                [self getGongGao:^{
                    // 调用回调函数
                    if (completion) {
                        completion();
                    }
                }];
            }];
            
        }
    } failure:^(NSError *error) {
        MyLog(@"getMiao获取失败=%@",error);
    }];
    
}

#pragma mark ---心跳定期验证 查询卡串状态 到期 冻结 删除 等

- (void)getXinTiao{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"timeout.ic";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];
    param[@"date"] = [self getSystemDate];
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            NSString*DRBool = dict[@"response"][@"data"];
            if ([DRBool containsString:@"5031"]) {
                MyLog(@"验证正常：%@",DRBool);
                [self getXinxi:^{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self getHMD:^{
                            验证状态=YES;
                        }];
                    });
                    
                }];
            }else if ([DRBool containsString:@"5030"]) {
                MyLog(@"验证到期：%@",DRBool);
                [self YZTC:[NSString stringWithFormat:@"卡密到期-到期时间\n%@",到期时间]];
                验证状态=NO;
                MyLog(@"用户在线中-返回：%@",DRBool);
            }else if ([DRBool containsString:@"1085"]) {
                MyLog(@"验证冻结：%@",DRBool);
                [self YZTC:@"卡密被冻结"];
                验证状态=NO;
                MyLog(@"用户在线中-返回：%@",DRBool);
            }else if ([DRBool containsString:@"1079"]) {
                MyLog(@"被迫下线：%@",DRBool);
                [self showText:@"被迫下线" message:@"卡密在其他设备APP登录\n设备数量-在线APP超过限制" Exit:YES];
                //被迫下线就闪退
                验证状态=NO;
                
            }else{
                验证状态=NO;
                MyLog(@"验证失败-状态码：%@",DRBool);
                [self YZTC:[NSString stringWithFormat:@"验证失败-状态码\n%@",DRBool]];
            }
            
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark ---取登录状态
- (void)getDenglu:(void (^)(void))completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"getlkinfo.ic";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];
    param[@"date"] = [self getSystemDate];
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            NSString*DRZT = dict[@"response"][@"data"];
            MyLog(@"DRZT=%@",DRZT);
            
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark ---读取拉黑状态
-(void)getHMD:(void (^)(void))completion{
    //请求的url
    NSString *requestStr = [NSString stringWithFormat:@"%@udid.php?code=%@",UDID_HOST,设备特征码];
    NSString *htmlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        //回到主线程的方法
        if ([htmlStr containsString:@"黑名单用户"]) {
            NSArray *strarr = [htmlStr componentsSeparatedByString:@"黑名单用户"];
            NSArray *strarr2 = [strarr[1] componentsSeparatedByString:@"联系管理员解除"];
            NSString*str=[NSString stringWithFormat:@"%@\n联系管理员解除",strarr2[0]];
            
            [self showText:@"设备拉黑" message:str Exit:YES];
        }
        
    });
    if (completion) {
        completion();
    }
}


#pragma mark ---公告弹窗
- (void)getGongGao:(void (^)(void))completion
{
    NSString*本地公告=[[NSUserDefaults standardUserDefaults] objectForKey:@"公告"];
    if ([本地公告 isEqual:软件公告]){
        if (completion) {
            completion();
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:软件公告 forKey:@"公告"];
        //发生更新才弹
        if ([弹窗类型 containsString:@"YES"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //系统弹窗
                UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                WX_NongShiFu123 *alert = [WX_NongShiFu123 alertControllerWithTitle:nil message:软件公告 preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if (completion) {
                        completion();
                    }
                }];
                [alert addAction:cancelAction];
                [rootViewController presentViewController:alert animated:YES completion:nil];
            });
            
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //SCL弹窗
                SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor=[UIColor systemGreenColor];
                alert.shouldDismissOnTapOutside = NO;
                [alert addButton:@"确定" actionBlock:^{
                    if (completion) {
                        completion();
                    }
                }];
                [alert showQuestion:@"公告" subTitle:软件公告 closeButtonTitle:nil duration:5];
            });
            
            
        }
    }
    
    
    
}


#pragma mark ---获取版本号

- (void)getVV:(void (^)(void))completion {
    if ([验证版本 containsString:@"YES"] && ![软件版本号 isEqual:JN_VERSION]) {
        验证状态=NO;
        //提示版本更新
        if ([弹窗类型 containsString:@"YES"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //系统弹窗
                UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                WX_NongShiFu123 *alert = [WX_NongShiFu123 alertControllerWithTitle:nil message:@"发现新版" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction;
                if (软件url地址.length>5) {
                    cancelAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:软件url地址] options:@{} completionHandler:^(BOOL success) {
                            exit(0);
                        }];
                    }];
                }else{
                    cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        // 取消操作
                        exit(0);
                    }];
                }
                [alert addAction:cancelAction];
                [rootViewController presentViewController:alert animated:YES completion:nil];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //SCL弹窗
                SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor=[UIColor systemGreenColor];
                alert.shouldDismissOnTapOutside = NO;
                
                if (软件url地址.length>5) {
                    [alert addButton:@"更新" actionBlock:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:软件url地址] options:@{} completionHandler:^(BOOL success) {
                            exit(0);
                        }];
                    }];
                }else{
                    [alert addButton:@"确定" actionBlock:^{
                        exit(0);
                    }];
                }
                
                [alert showNotice:@"发现更新" subTitle:@"新版发布请更新" closeButtonTitle:nil duration:0];
            });
            
            
        }
        
    }else{
        //        MyLog(@"版本验证通过");
        if (completion) {
            completion();
        }
    }
    
}



#pragma mark --- 验证使用

- (void)yanzhengAndUseIt:(NSString*)km{
    //参数开始组包
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"login.ic";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];//ssl是获取的全局参数，多开控制
    param[@"date"] = [self getSystemDate];
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"icid"] = km;
    param[@"icpwd"] = @"";
    param[@"key"] = 设备特征码;//绑定的机器码
    param[@"maxoror"] = 设备特征码;//登录标记区分机器
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            //这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
            if(![dict[@"response"][@"appsafecode"] isEqualToString:appsafecode]){
                MyLog(@"2");
                dict[@"response"][@"data"] = @"-2000";
            }
            
            NSString *dataString = dict[@"response"][@"data"];
            NSRange range = [dataString rangeOfString:@"|1081|"];
            if (range.location != NSNotFound) {
                //验证成功
                NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                if (arr.count >= 6)
                {
                    MyLog(@"验证成功=%@",dataString);
                    到期时间=arr[4];
                    NSString*fuwuqijqm=arr[2];
                    [getKeychain addKeychainData:km forKey:@"ShiSanGeDZKM"];
                    if ([验证公告 containsString:@"YES"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"公告"];
                    }
                    [self getGongGao:^{
                        if (!验证状态) {
                            [self jiebangTC:fuwuqijqm void:^{
                                [self getHMD:^{
                                    //每次启动都弹出
                                    NSString*str=[NSString stringWithFormat:@"验证成功-到期时间\n%@",arr[4]];
                                    NSString*dqsj=arr[4];
                                    [[NSUserDefaults standardUserDefaults] setObject:dqsj forKey:@"到期时间"];
                                    [[NSUserDefaults standardUserDefaults] setObject:km forKey:@"卡密"];
                                    if ([到期时间弹窗 containsString:@"YES"]) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self showText:str message:nil Exit:NO];
                                        });
                                        
                                    }else{
                                        BOOL 判断是否已经弹窗过=[[NSUserDefaults standardUserDefaults] boolForKey:@"到期弹窗"];
                                        //仅仅首次激活弹窗
                                        if (!判断是否已经弹窗过) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [self showText:str message:nil Exit:NO];
                                            });
                                            
                                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"到期弹窗"];
                                            
                                        }
                                    }
                                    验证状态=YES;
                                    static dispatch_once_t onceToken;
                                    dispatch_once(&onceToken, ^{
                                        dsq=[NSTimer scheduledTimerWithTimeInterval:BS_DSQ repeats:YES block:^(NSTimer * _Nonnull timer) {
                                            if (验证状态) {
                                                [self getXinTiao];
                                            }
                                        }];
                                        [[NSRunLoop currentRunLoop] addTimer:dsq forMode:NSRunLoopCommonModes];
                                        
                                        //启动你的图标辅助
                                        if(验证状态==YES){
                                            //验证成功 启动外挂代码在这 比如启动图标 启动菜单 其他某个功能 启动防封 等等
                                            
                                        }else{
                                            //验证失败==傻逼 先验证
                                        }
                                        
                                    });
                                    
                                    
                                }];
                                
                            }];
                            
                            
                            
                        }
                        
                    }];
                    
                }
            }else{
                MyLog(@"dataString=%@",dataString);
                [getKeychain removeKeychainDataForKey:@"ShiSanGeDZKM"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"到期弹窗"];
                //验证失败
                [self YZTC:dataString];
                
            }
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark ---获取时间
- (NSString *)getSystemDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}

#pragma mark --- 获取UDID码

- (void)getUDID:(void (^)(void))completion
{
    //读取本地UDID
    设备特征码=[getKeychain getKeychainDataForKey:@"DZUDID"];
    MyLog(@"ShiSanGeUDID=%@",设备特征码);
    //如果钥匙串没有UDID 折通过用户id去读取服务器获取
    //请求的url
    NSArray *strarr = [BSPHP_HOST componentsSeparatedByString:@"appid="];
    NSArray *strarr2 = [strarr[1] componentsSeparatedByString:@"&m="];
    NSString* daihao=strarr2[0];
    
    if (设备特征码.length<5 || 设备特征码==nil || 设备特征码==NULL) {
        //判断越狱ROOT注入情况下 直接读取
        static CFStringRef (*$MGCopyAnswer)(CFStringRef);
        void *gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
        $MGCopyAnswer = reinterpret_cast<CFStringRef (*)(CFStringRef)>(dlsym(gestalt, "MGCopyAnswer"));
        设备特征码=(__bridge NSString *)$MGCopyAnswer(CFSTR("SerialNumber"));
        if (设备特征码.length>6 && completion) {
            [getKeychain addKeychainData:设备特征码 forKey:@"DZUDID"];
            completion();
        }
        //非越狱 不存在就读取服务器安装描述文件获取
        NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
        NSArray *urlTypes = dict[@"CFBundleURLTypes"];
        NSString *urlSchemes = nil;
        //读取APP的跳转URL
        for (NSDictionary *scheme in urlTypes) {
            urlSchemes = scheme[@"CFBundleURLSchemes"][0];
        }
        //生成随机用户ID
        NSString* suijiid;
        //读取钥匙串用户ID
        suijiid=[getKeychain getKeychainDataForKey:@"SJUSERID"];
        MyLog(@"suijiid=%@",suijiid);
        //不存在就储存随机生成id并且储存钥匙串
        if (suijiid.length<=5) {
            NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            NSMutableString *randomString = [NSMutableString stringWithCapacity:15];
            for (int i = 0; i < 15; i++) {
                [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned int)[letters length])]];
            }
            MyLog(@"随机生成的码：%@", randomString);
            suijiid=[NSString stringWithFormat:@"%@",randomString];
            [getKeychain addKeychainData:suijiid forKey:@"SJUSERID"];
            MyLog(@"生成随机ID=%@",suijiid);
        }
        
        
        //通过ID读取服务器的UDID
        NSString *requestStr = [NSString stringWithFormat:@"%@udid%@.txt",UDID_HOST,suijiid];
        MyLog(@"requestStr=%@",requestStr);
        // 创建 NSURLSession 对象
        NSURLSession *session = [NSURLSession sharedSession];
        // 创建 NSURL 对象
        NSURL *url = [NSURL URLWithString:requestStr];
        // 创建 NSURLSessionDataTask 对象
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                // URL 返回错误
                MyLog(@"URL 返回错误：%@", error);
                [self showText:@"UDID获取错误" message:[NSString stringWithFormat:@"%@",error] Exit:YES];
            } else {
                // URL 正常
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if ([httpResponse statusCode] == 404) {
                    MyLog(@"URL 返回 404 错误 提示用户安装UDID描述文件");
                    //如果有错误 证明服务器没有 那就安装描述文件获取
                    NSString*url=[NSString stringWithFormat:@"%@udid.php?id=%@&openurl=%@&daihao=%@",UDID_HOST,suijiid,urlSchemes,daihao];
                    MyLog(@"URL 地址：%@", url);
                    if ([弹窗类型 containsString:@"YES"]) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            WX_NongShiFu123 *alertController = [WX_NongShiFu123 alertControllerWithTitle:nil message:@"安装描述文件-获取绑定机器码" preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"退出应用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                exit(0);
                            }]];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"确定安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
                                    exit(0);
                                }];
                                
                            }]];
                            
                            UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                            [rootViewController presentViewController:alertController animated:YES completion:nil];
                        });
                        
                    }else{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                            alert.customViewColor=[UIColor systemGreenColor];
                            alert.shouldDismissOnTapOutside = NO;
                            [alert addButton:@"退出应用" actionBlock:^{
                                exit(0);
                            }];
                            [alert addButton:@"确定安装" actionBlock:^{
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
                                    exit(0);
                                }];
                            }];
                            [alert showQuestion:@"安装描述文件" subTitle:@"获取机器码进行卡密绑定" closeButtonTitle:nil duration:0];
                        });
                        
                    }
                } else {
                    MyLog(@"URL 正常");
                    // 打印返回值非404的html字符串
                    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    MyLog(@"URL 返回的 HTML 字符串：%@", htmlString);
                    //删除换行和空格
                    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                    NSArray *strarr = [[htmlString stringByTrimmingCharactersInSet:whitespace] componentsSeparatedByString:@"|"];
                    MyLog(@"URL 返回的 strarr字符串：%@", strarr);
                    NSString*udidstr=strarr[0];
                    NSString*NewOld=strarr[1];
                    NSString*heimingdan=strarr[2];
                    NSString*beizhu=strarr[3];
                    MyLog(@"URL 返回的 udidstr：%@", udidstr);
                    //判断是否黑名单用户 是则拉黑提示备注内容 并且闪退
                    NSString *remohcurl = [NSString stringWithFormat:@"%@udid.php?rm=%@",UDID_HOST,suijiid];
                    if ([heimingdan containsString:@"黑名单用户"]) {
                        [self remohc:remohcurl void:^{
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [getKeychain removeKeychainDataForKey:@"DZUDID"];
                                [self showText:heimingdan message:beizhu Exit:YES];
                            });
                        }];
                        
                    }else{
                        设备特征码 = udidstr;
                        //如果没有错误 储存UDID到钥匙串
                        [getKeychain addKeychainData:设备特征码 forKey:@"DZUDID"];
                        是否新用户=[NewOld containsString:@"新用户"];
                        if (是否新用户) {
                            NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                            NSMutableString *randomString = [NSMutableString stringWithCapacity:15];
                            for (int i = 0; i < 25; i++) {
                                [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned int)[letters length])]];
                            }
                            MyLog(@"随机生成的码：%@", randomString);
                            NSString*SJKM=[NSString stringWithFormat:@"%@",randomString];
                            [getKeychain addKeychainData:SJKM forKey:@"ShiSanGeDZKM"];
                        }
                        
                        [self remohc:remohcurl void:^{
                            if (completion) {
                                completion();
                            }
                        }];
                        
                    }
                }
            }
        }];
        
        // 启动任务
        [dataTask resume];
        
    }else{
        if (completion) {
            completion();
        }
    }
    
}

- (void)remohc:(NSString*)url void:(void (^)(void))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求的url
        MyLog(@"删除缓存url=%@",url);
        NSString *htmlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
        if(htmlStr){
            if (completion) {
                completion();
            }
        }
        if (completion) {
            completion();
        }
    });
}

#pragma mark ---解绑
- (void)jiebang:(NSString*)km Text:(NSString*)Text{
    //参数开始组包
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"setcarnot.ic";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];//ssl是获取的全局参数，app第一次启动时候获取的
    param[@"date"] = [self getSystemDate];
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"icid"] = km;
    param[@"icpwd"] = @"";
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            //这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
            if(![dict[@"response"][@"appsafecode"] isEqualToString:appsafecode]){
                dict[@"response"][@"data"] = @"-2000";
            }
            NSString *dataString = dict[@"response"][@"data"];
            NSString*str=[NSString stringWithFormat:@"%@\n换绑信息已复制",dataString];
            UIPasteboard*jtb=[UIPasteboard generalPasteboard];
            jtb.string=str;
            if([dataString containsString:@"成功"]){
                [getKeychain addKeychainData:km forKey:@"ShiSanGeDZKM"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showText:@"换绑成功" message:str Exit:NO];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self yanzhengAndUseIt:km];
                    });
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showText:@"换绑失败" message:str Exit:NO];
                });
                
            }
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}


#pragma mark ---解绑弹窗
- (void)jiebangTC:(NSString*)fwqjqm void:(void (^)(void))completion
{
    if ([支持解绑 containsString:@"YES"]) {
        if (![fwqjqm containsString:设备特征码]) {
            NSString*str=[NSString stringWithFormat:@"卡密绑定机器非本机\n本机序列号\n%@\n卡密绑定序号\n%@\n解绑并换绑本机将扣除时间%@秒\n上一个绑定设备解除绑定",设备特征码,fwqjqm,解绑扣除时间];
            MyLog(@"解绑扣除时间=%@",解绑扣除时间);
            if ([弹窗类型 containsString:@"YES"]) {
                MyLog(@"系统弹窗时间=%@",解绑扣除时间);
                //系统弹窗
                dispatch_async(dispatch_get_main_queue(), ^{
                    WX_NongShiFu123 *alertController = [WX_NongShiFu123 alertControllerWithTitle:@"警告" message:str preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"换绑到本机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSString*km=[getKeychain getKeychainDataForKey:@"ShiSanGeDZKM"];
                        [self jiebang:km Text:str];
                    }];
                    UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"取消退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        exit(0);
                    }];
                    [alertController addAction:okAction];
                    [alertController addAction:okAction2];
                    UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                    [rootViewController presentViewController:alertController animated:YES completion:nil];
                    
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //SCL弹窗
                    SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                    alert.customViewColor=[UIColor systemGreenColor];
                    alert.shouldDismissOnTapOutside = NO;
                    [alert addButton:@"换绑到本机" actionBlock:^{
                        NSString*km=[getKeychain getKeychainDataForKey:@"ShiSanGeDZKM"];
                        [self jiebang:km Text:str];
                    }];
                    [alert addButton:@"取消退出" actionBlock:^{
                        exit(0);
                    }];
                    [alert showQuestion:@"警告" subTitle:str closeButtonTitle:nil duration:0.0f];
                    
                });
            }
        }else{
            if (completion) {
                completion();
            }
        }
        
    }else{
        if (completion) {
            completion();
        }
    }
}


#pragma mark ---试用
- (void)shiyong:(void (^)(void))completion{
    if ([试用模式 containsString:@"YES"]) {
        //请求的url
        MyLog(@"开始试用");
        if (是否新用户) {
            //开始注册卡密
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
            param[@"api"] = @"AddCardFeatures.key.ic";
            param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];
            param[@"date"] = [self getSystemDate];
            param[@"md5"] = @"";
            param[@"mutualkey"] = BSPHP_MUTUALKEY;
            param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
            param[@"maxoror"] = 设备特征码;//多开控制
            param[@"key"] = 设备特征码;//必填,建议让用户填QQ或者联系方式这样方便联系用户(自己想象)
            param[@"carid"] = [getKeychain getKeychainDataForKey:@"ShiSanGeDZKM"];//必填,建议让用户填QQ或者联系方式这样方便联系用户(自己想象)
            [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {
                    NSString*dataString = dict[@"response"][@"data"];
                    MyLog(@"dataString=%@",dataString);
                    if ([dataString containsString:@"|1081|"]) {
                        NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                        if (arr) {
                            
                        }
                        MyLog(@"试用成功 到期时间：%@  BS后台-软件配置-基础配置 首次使用送 ",arr[4]);
                        if (completion) {
                            completion();
                        }
                    }else{
                        MyLog(@"bus1081");
                        if (completion) {
                            completion();
                        }
                    }
                    
                }
            } failure:^(NSError *error) {
                MyLog(@"注册失败：%@",error);
                if (completion) {
                    completion();
                }
            }];
        }else{
            //有查到记录 试用失败 直接回调
            if (completion) {
                completion();
            }
        }
        
    }else{
        if (completion) {
            completion();
        }
        
    }
}


#pragma mark ---IDFV
- (void)getIDFV:(void (^)(void))completion
{
    //优先读取钥匙串 保证同一个App的多开读取到同一个IDFV
    设备特征码=[getKeychain getKeychainDataForKey:@"ShiSanGeIDFV"];
    if (设备特征码==NULL || 设备特征码.length<5 ) {
        //钥匙串没有就读取当前App的IDFA 并且储存为统一钥匙串
        设备特征码 = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        //储存
        [getKeychain addKeychainData:设备特征码 forKey:@"ShiSanGeIDFV"];
        //最后才回调 避免读取钥匙串为空也回调null为机器码
        if (completion) {
            completion();
        }
    }else{
        if (completion) {
            completion();
        }
    }
    
    
}


#pragma mark ---弹窗
-(void)showText:(NSString* _Nullable)Title message:(NSString* _Nullable)message Exit:(BOOL)Exit
{
    if ([弹窗类型 containsString:@"YES"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //系统弹窗
            UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            WX_NongShiFu123 *alert = [WX_NongShiFu123 alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 确定操作
                if(Exit){
                    exit(0);
                }
            }];
            [alert addAction:okAction];
            [rootViewController presentViewController:alert animated:YES completion:nil];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //SCL弹窗
            SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
            alert.customViewColor=[UIColor systemGreenColor];
            alert.shouldDismissOnTapOutside = NO;
            [alert addButton:@"确定" actionBlock:^{
                if(Exit){
                    exit(0);
                }
            }];
            [alert showEdit:Title subTitle:message closeButtonTitle:nil duration:0];
        });
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // UIAlertController 显示在最前面
    MyLog(@"UIAlertController 显示在最前面");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 检测 UIAlertController 是否被隐藏或移除
    if (self.isBeingDismissed || self.isMovingFromParentViewController) {
        // UIAlertController 被其他视图控制器覆盖，重新弹窗
        MyLog(@"UIAlertController 被其他视图控制器覆盖，重新弹窗");
        
        // 在这里添加你的处理代码，例如暂停定时器或隐藏 UIAlertController 等
        if (验证状态)return;
        // 重新弹窗
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [rootViewController presentViewController:self animated:YES completion:nil];
        });
    }
}
@end
