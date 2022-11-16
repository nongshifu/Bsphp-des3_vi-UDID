//
//  ViewController.h
//  Radar
//
//  Created by 十三哥 on 2022/8/19.
//
#import "UIDevice+VKKeychainIDFV.h"
#import "QQ350722326.h"
#import "LRKeychain.h"
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

#import "NSString+MD5.h"
#import "Config.h"

#import <AdSupport/ASIdentifierManager.h>
#import "MBProgressHUD+NJ.h"
#include <sys/sysctl.h>
#include <string>
#import <dlfcn.h>
static NSTimer*timer;
static NSString* DQTC;//到期时间弹窗
static NSString* UDIDORIDFA;//验证udid还是idfa
static NSString* YZBB;//验证版本更新
static NSString* GZB;//过直播
static NSString* YZ000;//验证机器码是否是
@implementation NSObject (checkStatus)

-(void)Bsphp{
    NSLog(@"1111111");
    static NSString*描述;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] =@"miao.in";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            描述 = dict[@"response"][@"data"];
            NSLog(@"描述=%@",描述);
            NSArray *arr = [描述 componentsSeparatedByString:@"\n"];
            DQTC=arr[0];
            UDIDORIDFA=arr[1];
            YZBB=arr[2];
            GZB=arr[3];
            YZ000=arr[4];
            if ([GZB containsString:@"YES"]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GZB"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"GZB"];
            }
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"] != nil)
            {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"api"] = @"login.ic";
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
                dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
                [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                NSDate *date = [NSDate date];
                NSTimeZone * zone = [NSTimeZone systemTimeZone];
                NSInteger interval = [zone secondsFromGMTForDate:date];
                NSDate * nowDate = [date dateByAddingTimeInterval:interval];
                NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
                param[@"date"] = nowDateStr;
                param[@"md5"] = @"";
                param[@"mutualkey"] = BSPHP_MUTUALKEY;
                param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"];
                param[@"icpwd"] = @"";
                param[@"key"] = [NSObject getIDFA];
                param[@"maxoror"] = [NSObject getIDFA];
                if ([YZ000 containsString:@"YES"] && [[NSObject getIDFA] containsString:@"000-000"]) {
                    return;
                }
                [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject)
                 {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    
                    if(!dict){
                        exit(0);//没数据 直接闪退 不用复制机器码码
                    }else
                    {
                        NSString *dataString = dict[@"response"][@"data"];
                        NSRange range = [dataString rangeOfString:@"|1081|"];
                        
                        if(range.location != NSNotFound)
                        {
                            
                            NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                            if (arr.count >= 6)
                            {
                                if(![dataString containsString:[NSObject getIDFA]]){
                                    [MBProgressHUD showError: @"授权错误，机器码不正确\n联系管理员解绑或更换卡密" HideTime:3];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        
                                        [self processActivate];
                                    });
                                    
                                    
                                }else{
                                    if ([DQTC containsString:@"YES"]) {
                                        NSString *showMsg = [NSString stringWithFormat:@"授权成功,到期时间\n %@", arr[4]];
                                        [MBProgressHUD showSuccess:showMsg  HideTime:3];
                                        
                                    }
                                    
                                    //验证版本
                                    static dispatch_once_t onceToken;
                                    dispatch_once(&onceToken, ^{
                                        if([YZBB containsString:@"YES"]){
                                            //验证通过后验证版本 和公告
                                            [NSObject loadbanben];
                                        }
                                    });
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [NSObject gonggao];//公告
                                    });
                                    
                                    //验证通过后在这里启动你的辅助
                                    [NSObject dingshiqi];
                                    
                                }
                            }
                            
                        }
                        else
                        {
                            [MBProgressHUD showError:dataString HideTime:3];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               
                                [self processActivate];
                            });
                            
                            
                        }
                    }
                } myfailure:^(NSError *error)
                 {
                    NSString*shoerror=[NSString stringWithFormat:@"%@",error];
                    [MBProgressHUD showError:shoerror HideTime:3];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self processActivate];
                    });
                }];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                               {
                    [self processActivate];
                });
            }
            
        }
    } myfailure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
            [self processActivate];
        });
    }];
}

/**
 加载版本信息 API
 */
- (void)loadbanben{
    NSString *localv = JN_VERSION;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] =@"v.in";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                NSString *version = dict[@"response"][@"data"];
                BOOL result = [version isEqualToString:localv];
                if (!result){
                    NSString*url=[NSObject getnew];
                    [MBProgressHUD showError:@"请更新新版,5秒后跳转下载" HideTime:5];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            exit(0);
                        });
                    });
                }
            }
        } myfailure:^(NSError *error) {
            [MBProgressHUD showError:@"网络链接失败" HideTime:3];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                exit(0);
            });
        }];
    });
}
/**
 获取版本URL
 */
+ (NSString*)getnew{
    static NSString *vdate;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] =@"url.in";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                vdate = dict[@"response"][@"data"];
            }
        } myfailure:^(NSError *error) {
            
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             exit(0);
             });
        }];
    });
    return vdate;
}

/**
 加载公告 API
 */
- (void)gonggao{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"api"] = @"gg.in";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
        dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
        [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        param[@"BSphpSeSsL"] = [dateStr MD5Digest];
        NSDate *date = [NSDate date];
        NSTimeZone * zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        NSDate * nowDate = [date dateByAddingTimeInterval:interval];
        NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
        param[@"date"] = nowDateStr;
        param[@"md5"] = @"";
        param[@"mutualkey"] = BSPHP_MUTUALKEY;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {
                   
                    NSString *message = dict[@"response"][@"data"];
                    NSString*本地公告=[[NSUserDefaults standardUserDefaults] objectForKey:@"公告"];
                    if (![message isEqual:本地公告]) {
                        [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"公告"];
                        [MBProgressHUD showText:message HideTime:3];
                    }
                    
                }
            } myfailure:^(NSError *error) {
                [MBProgressHUD showError:@"网络链接失败" HideTime:3];
            }];
        });
    });
}

/**
 激活弹窗
 */

/**
 提示条
 */
- (void)processActivate
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入激活码" preferredStyle:UIAlertControllerStyleAlert];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入激活码";
        textField.secureTextEntry = NO;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.layer.masksToBounds=YES;
        
    }];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (userNameTextField.text.length<2) {
            userNameTextField.placeholder=@"输入为空-请先输入";
            [NSObject processActivate];
        }else{
            [NSObject YzCode:userNameTextField.text];
        }
        
    }]];
    UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
/**
 验证逻辑
 */
- (void)YzCode:(NSString *)code
{
    //授权码验证
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] = @"login.ic";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"icid"] = code;
    param[@"icpwd"] = @"";
    param[@"key"] = [self getIDFA];
    param[@"maxoror"] = [self getIDFA];
    [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject)
     {
        NSError*error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (dict)
        {
            NSString *dataString = dict[@"response"][@"data"];
            NSRange range = [dataString rangeOfString:@"|1081|"];
            if (range.location != NSNotFound)
            {
                NSString *activationDID = [[NSUserDefaults standardUserDefaults]objectForKey:@"activationDeviceID"];
                
                if (![activationDID isEqualToString:code])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"activationDeviceID"];
                }
                NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                if (arr.count >= 6)
                {
                    if(![dataString containsString:[NSObject getIDFA]]){
                        [MBProgressHUD showError:@"授权错误，机器码不正确\n联系管理员解绑或更换卡密" HideTime:3];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self processActivate];
                        });
                        
                    }else{
                        NSString *showMsg = [NSString stringWithFormat:@"授权成功-到期时间\n%@", arr[4]];
                        [MBProgressHUD showSuccess:showMsg HideTime:3];
                        
                    }
                }
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *messageStr = dict[@"response"][@"data"];
                    [MBProgressHUD showError:messageStr HideTime:3];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self processActivate];
                    });
                });
                
                
            }
        }
        else{
            [self processActivate];
        }
    } myfailure:^(NSError *error)
     {
        [self processActivate];
    }];
}

/**
 获取设备码IDFA 刷机变 升级变 -设置-隐私-限制广告跟踪 开关 变 UDID 永久不变 推荐
 */

-(NSString*)getIDFA{
    NSString* UDID;
    
    if ([UDIDORIDFA containsString:@"YES"]) {
        //获取当前APP的跳转地址 多开版可能会跳转官方版 安装描述文件后手动打开多开版即可
        NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
        NSArray *urlTypes = dict[@"CFBundleURLTypes"];
        NSString *urlSchemes = nil;
        for (NSDictionary *scheme in urlTypes) {
            urlSchemes = scheme[@"CFBundleURLSchemes"][0];
            NSLog(@"urlSchemes=%@",urlSchemes);
        }
        //生成随机ID 作为用户ID
        NSInteger cc;
        cc=[[NSUserDefaults standardUserDefaults] integerForKey:@"cc"];
        if (cc==0) {
            cc=arc4random() % 100000;
            //存储随机ID 作为用户ID
            [[NSUserDefaults standardUserDefaults] setInteger:cc forKey:@"cc"];
        }
        //读取本地储存的udid
        UDID=[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"];
        if (UDID.length>10 && ![UDID containsString:@"0000"]) {
            //如果存在 则返回UDID
            return UDID;
        }
        //如果不存在 则根据随机ID 访问服务器读取udid 安装描述文件的时候根据 用户ID储存在服务器上的
        NSString *requestStr = [NSString stringWithFormat:@"%@udid%ld.txt",UDID_HOST,cc];
        NSError*error;
        UDID = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:&error];
        if (error==nil) {
            //读取到就储存本地
            [[NSUserDefaults standardUserDefaults] setObject:UDID forKey:@"udid"];
            //存储后返回UDID字符串
            return UDID;
        }else{
            //没读取到证明没获取过 就获取描述文件安装 地址内包含回调的CFBundleURLSchemes用于跳回app 包含用户ID 用于在服务器储存UDID 和查询
            NSString*url=[NSString stringWithFormat:@"%@udid.php?id=%ld&openurl=%@",UDID_HOST,cc,urlSchemes];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                exit(0);
            });
            return @"error";
        }
    }else{
        ASIdentifierManager *as = [ASIdentifierManager sharedManager];
        
        UDID= [UIDevice VKKeychainIDFV];;
//        UDID= as.advertisingIdentifier.UUIDString;
        if ([YZ000 containsString:@"YES"]) {
            if ([UDID containsString:@"0000-00"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"udid"];
                [MBProgressHUD showError:@"IDFA机器码获取失败\n获取到0000-000-000错误"  HideTime:3];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
                });
            }
        }
    }
    return UDID;
}

-(void)dingshiqi
{
    timer=[NSTimer timerWithTimeInterval:BS_DSQ repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"api"] = @"login.ic";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
            dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
            [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
            NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
            param[@"BSphpSeSsL"] = [dateStr MD5Digest];
            NSDate *date = [NSDate date];
            NSTimeZone * zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:date];
            NSDate * nowDate = [date dateByAddingTimeInterval:interval];
            NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            param[@"date"] = nowDateStr;
            param[@"md5"] = @"";
            param[@"mutualkey"] = BSPHP_MUTUALKEY;
            param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"];
            param[@"icpwd"] = @"";
            param[@"key"] = [NSObject getIDFA];
            param[@"maxoror"] = [NSObject getIDFA];
            [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject)
             {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                if(!dict){
                    exit(0);//没数据 直接闪退 不用复制机器码码
                }else
                {
                    NSString *dataString = dict[@"response"][@"data"];
                    NSRange range = [dataString rangeOfString:@"|1081|"];
                    
                    if(range.location != NSNotFound)
                    {
                        [NSObject loadbanben];
                        [NSObject gonggao];
                        return;
                    }
                    else
                    {
                        //验证时间
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                       {
                            [NSObject processActivate];
                        });
                    }
                }
            } myfailure:^(NSError *error)
             {
                
            }];
        });
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
@end




