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
#import "SCLAlertView.h"
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
static NSString* 弹窗类型;//验证机器码是否是
static NSString *vdate;
@implementation NSObject (checkStatus)

-(void)Bsphp{
    static NSString*描述;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] =@"miao.in";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            描述 = dict[@"response"][@"data"];
            NSArray *arr = [描述 componentsSeparatedByString:@"\n"];
            DQTC=arr[0];
            UDIDORIDFA=arr[1];
            YZBB=arr[2];
            GZB=arr[3];
            YZ000=arr[4];
            弹窗类型=@"YES";
            if ([GZB containsString:@"YES"]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GZB"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"GZB"];
            }
            NSString*getudid=[NSObject getIDFA];
            if (getudid.length>5) {
                if([[NSUserDefaults standardUserDefaults] objectForKey:@"km"] != nil)
                {
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    param[@"api"] = @"login.ic";
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
                    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
                    param[@"date"] = nowDateStr;
                    param[@"md5"] = @"";
                    param[@"mutualkey"] = BSPHP_MUTUALKEY;
                    param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"km"];
                    param[@"icpwd"] = @"";
                    param[@"key"] = [NSObject getIDFA];
                    param[@"maxoror"] = [NSObject getIDFA];
                    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject)
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
                                        if ([弹窗类型 containsString:@"YES"]) {
                                            [MBProgressHUD showError: @"授权错误，机器码不正确\n联系管理员解绑或更换卡密" HideTime:3];
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                [self CodeConfig];
                                            });
                                        }else{
                                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                            alert.customViewColor=[UIColor systemGreenColor];
                                            [alert addButton:@"确定" actionBlock:^(void) {
                                                [self CodeConfig];
                                            }];
                                            [alert showError:@"错误" subTitle:@"授权错误，机器码不正确\n联系管理员解绑或更换卡密" closeButtonTitle:nil duration:5.0f];
                                        }
                                        
                                        
                                    }else{
                                        if ([DQTC containsString:@"YES"]) {
                                            NSString *showMsg = [NSString stringWithFormat:@"授权成功,到期时间\n %@", arr[4]];
                                            if ([弹窗类型 containsString:@"YES"]) {
                                                NSString *showMsg = [NSString stringWithFormat:@"授权成功,到期时间\n %@", arr[4]];
                                                [MBProgressHUD showSuccess:showMsg  HideTime:3];
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
                                            }else{
                                                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                [alert addButton:@"确定" actionBlock:^(void) {
                                                    //验证版本
                                                    static dispatch_once_t onceToken;
                                                    dispatch_once(&onceToken, ^{
                                                        if([YZBB containsString:@"YES"]){
                                                            //验证通过后验证版本 和公告
                                                            [NSObject loadbanben];
                                                        }
                                                    });
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                        [NSObject gonggao];//公告
                                                    });
                                                    
                                                    //验证通过后在这里启动你的辅助
                                                    [NSObject dingshiqi];
                                                    
                                                }];
                                                [alert showSuccess:@"验证成功" subTitle:showMsg closeButtonTitle:nil duration:nil];
                                            }
                                            
                                            
                                           
                                        }
                                        
                                        
                                        
                                    }
                                }
                                
                            }
                            else
                            {
                                if ([弹窗类型 containsString:@"YES"]) {
                                    [MBProgressHUD showError:dataString HideTime:3];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self CodeConfig];
                                    });
                                }else{
                                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                    [alert addButton:@"确定" actionBlock:^(void) {
                                        [self CodeConfig];
                                    }];
                                    [alert showError:@"验证失败" subTitle:dataString closeButtonTitle:nil duration:nil];
                                }
                                
                                
                                
                                
                            }
                        }
                    } failure:^(NSError *error)
                     {
                        NSString*shoerror=[NSString stringWithFormat:@"%@",error];
                        if ([弹窗类型 containsString:@"YES"]) {
                            
                            [MBProgressHUD showError:shoerror HideTime:3];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [self CodeConfig];
                            });
                        }else{
                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                            [alert addButton:@"确定" actionBlock:^(void) {
                                [self CodeConfig];
                            }];
                            [alert showError:@"错误" subTitle:shoerror closeButtonTitle:nil duration:nil];
                        }
                        
                        
                        
                    }];
                }
                else
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                   {
                        [NSObject CodeConfig];
                    });
                }
            }else{
                [NSObject getIDFA];
            }
            
            
        }
    } failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
            //没网络的情况
            //[NSObject CodeConfig];
            [NSObject Bsphp];
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
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                NSString *version = dict[@"response"][@"data"];
                BOOL result = [version isEqualToString:localv];
                if (!result){
                    NSString*url=[NSObject getnew];
                    if ([弹窗类型 containsString:@"YES"]) {
                        [MBProgressHUD showError:@"请更新新版,5秒后跳转下载" HideTime:5];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                exit(0);
                            });
                        });
                    }else{
                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                        [alert addButton:@"更新" actionBlock:^(void) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vdate] options:@{} completionHandler:nil];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                exit(0);
                            });
                        }];
                        [alert addButton:@"取消" actionBlock:^(void) {
                            
                        }];
                        [alert showNotice:@"发现新版" subTitle:@"请及时更新新版" closeButtonTitle:nil duration:5.0f];
                    }
                    
                    
                    
                }
            }
        } failure:^(NSError *error) {
            if ([弹窗类型 containsString:@"YES"]) {
                [MBProgressHUD showError:@"网络链接失败" HideTime:3];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
                });
            }else{
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addButton:@"确定" actionBlock:^(void) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vdate] options:@{} completionHandler:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(0);
                    });
                }];
                [alert showNotice:@"网络错误" subTitle:@"网络链接失败" closeButtonTitle:nil duration:5.0f];
            }
            
            
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
        [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                vdate = dict[@"response"][@"data"];
            }
        } failure:^(NSError *error) {
            
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
        NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
        param[@"date"] = nowDateStr;
        param[@"md5"] = @"";
        param[@"mutualkey"] = BSPHP_MUTUALKEY;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {
                    NSString *message = dict[@"response"][@"data"];
                    NSString*本地公告=[[NSUserDefaults standardUserDefaults] objectForKey:@"公告"];
                    if (![message isEqual:本地公告]) {
                        [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"公告"];
                        if([弹窗类型 containsString:@"YES"]){
                            [MBProgressHUD showText:message HideTime:3];
                        }else{
                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                            [alert showSuccess:@"公告" subTitle:message closeButtonTitle:@"确定" duration:5.0f];
                        }
                        
                    }
                }
            } failure:^(NSError *error) {
                if([弹窗类型 containsString:@"YES"]){
                    [MBProgressHUD showError:@"公告获取失败" HideTime:3];
                }else{
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showError:@"公告" subTitle:@"公告获取失败" closeButtonTitle:@"确定" duration:5.0f];
                }
                
                
            }];
        });
    });
}

/**
 激活弹窗
 */
static UIViewController * rootViewController;
- (void)CodeConfig
{
    if([弹窗类型 containsString:@"YES"]){
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
        if (购买地址.length>3) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"购买" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:购买地址] options:@{} completionHandler:^(BOOL success) {
                    exit(0);
                }];
            }]];
        }else{
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                exit(0);
            }]];
        }
        
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            if (userNameTextField.text.length<2) {
                userNameTextField.placeholder=@"输入为空-请先输入";
                [NSObject CodeConfig];
            }else{
                [NSObject YzCode:userNameTextField.text];
            }
            
        }]];
        UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [rootViewController presentViewController:alertController animated:YES completion:nil];
    }else{
        SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
        alert.customViewColor=[UIColor systemGreenColor];
        alert.shouldDismissOnTapOutside = NO;
        SCLTextView *textF =   [alert addTextField:@"请在30秒内填写授权码"setDefaultText:nil];
        [alert addButton:@"粘贴" validationBlock:^BOOL{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            textF.text =pasteboard.string;
            return NO;
        }actionBlock:^{}];
        if (购买地址.length>3) {
            [alert addButton:@"购买" actionBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:购买地址] options:@{} completionHandler:nil];
            }];
        }
        
        [alert alertDismissAnimationIsCompleted:^{
            if (textF.text.length==0) {
                [NSObject CodeConfig];
            }else{
                [NSObject YzCode:textF.text];
            }
        }];
        [alert showEdit:@"授权" subTitle:[NSString stringWithFormat:@"请输入您的授权码\n%@",[self getIDFA]] closeButtonTitle:@"授权" duration:nil];
    }
    
    
}
- (void)dismiss:(UIViewController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
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
    NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"icid"] = code;
    param[@"icpwd"] = @"";
    param[@"key"] = [self getIDFA];
    param[@"maxoror"] = [self getIDFA];
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject)
     {
        NSError*error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (dict)
        {
            NSString *dataString = dict[@"response"][@"data"];
            NSRange range = [dataString rangeOfString:@"|1081|"];
            if (range.location != NSNotFound)
            {
                NSString *activationDID = [[NSUserDefaults standardUserDefaults]objectForKey:@"km"];
                
                if (![activationDID isEqualToString:code])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"km"];
                }
                NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                if (arr.count >= 6)
                {
                    if(![dataString containsString:[NSObject getIDFA]]){
                        if ([弹窗类型 containsString:@"YES"]) {
                            [MBProgressHUD showError:@"错误,绑定机器码非本机"  HideTime:3];
                        }else{
                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                            alert.customViewColor=[UIColor systemGreenColor];
                            [alert addButton:@"确定" actionBlock:^(void) {
                                [NSObject CodeConfig];
                            }];
                            [alert showError:@"验证错误" subTitle:@"授权错误，机器码不正确\n联系管理员解绑或更换卡密" closeButtonTitle:nil duration:nil];
                        }
                        
                    }else{
                        NSString *showMsg = [NSString stringWithFormat:@"授权成功-到期时间\n%@\n重启App生效", arr[4]];
                        if ([弹窗类型 containsString:@"YES"]) {
                            [MBProgressHUD showSuccess:showMsg HideTime:4];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                exit(0);
                            });
                        }else{
                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                            alert.customViewColor=[UIColor systemGreenColor];
                            [alert addButton:@"确定" actionBlock:^{
                                exit(0);
                            }];
                            [alert showSuccess:@"验证成功" subTitle:showMsg closeButtonTitle:nil duration:nil];
                        }
                    }
                }
            }
            else
            {
                NSString *messageStr = dict[@"response"][@"data"];
                if ([弹窗类型 containsString:@"YES"]) {
                    [MBProgressHUD showError:messageStr  HideTime:3];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NSObject CodeConfig];
                    });
                }else{
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    alert.customViewColor=[UIColor systemGreenColor];
                    [alert addButton:@"确定" actionBlock:^(void) {
                        [NSObject CodeConfig];
                    }];
                    [alert showError:@"验证错误" subTitle:messageStr closeButtonTitle:nil duration:nil];
                }
                
                
            }
        }
        else{
            [self CodeConfig];
        }
    } failure:^(NSError *error)
     {
        [self CodeConfig];
    }];
}

/**
 获取设备码IDFA 刷机变 升级变 -设置-隐私-限制广告跟踪 开关 变 UDID 永久不变 推荐
 */

-(NSString*)getIDFA{
    NSString* UDID;
    if ([UDIDORIDFA containsString:@"YES"]) {
        NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
        NSArray *urlTypes = dict[@"CFBundleURLTypes"];
        NSString *urlSchemes = nil;
        for (NSDictionary *scheme in urlTypes) {
            urlSchemes = scheme[@"CFBundleURLSchemes"][0];
        }
        NSInteger cc;
        cc=[[NSUserDefaults standardUserDefaults] integerForKey:@"cc"];
        //不存在就储存cc
        if (cc==0) {
            cc=arc4random() % 100000;
            [[NSUserDefaults standardUserDefaults] setInteger:cc forKey:@"cc"];
        }
        //读取本地UDID
        UDID=[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"];
        //存在就返回UDID
        if (UDID.length>10) {
            if ([YZ000 containsString:@"YES"]) {
                if ([UDID containsString:@"0000-000"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"udid"];
                    exit(0);
                }
            }
            return UDID;
        }
        //不存在就读取服务器的txt
        NSString *requestStr = [NSString stringWithFormat:@"%@udid%ld.txt",UDID_HOST,cc];
        NSError*error;
        UDID = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:&error];
        if (error==nil) {
            //储存
            [[NSUserDefaults standardUserDefaults] setObject:UDID forKey:@"udid"];
            return UDID;
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor=[UIColor systemGreenColor];
                [alert addButton:@"安装描述文件" actionBlock:^(void) {
                    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
                    NSArray *urlTypes = dict[@"CFBundleURLTypes"];
                    NSString *urlSchemes = nil;
                    for (NSDictionary *scheme in urlTypes) {
                        urlSchemes = scheme[@"CFBundleURLSchemes"][0];
                    }
                    NSInteger cc;
                    cc=[[NSUserDefaults standardUserDefaults] integerForKey:@"cc"];
                    if (cc==0) {
                        cc=arc4random() % 100000;
                        [[NSUserDefaults standardUserDefaults] setInteger:cc forKey:@"cc"];
                    }
                    NSString*url=[NSString stringWithFormat:@"%@udid.php?id=%ld&openurl=%@",UDID_HOST,cc,urlSchemes];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(0);
                    });
                    
                }];
                [alert addButton:@"退出应用" actionBlock:^(void) {
                    exit(0);
                }];
                
                [alert showNotice:@"温馨提示" subTitle:@"请安装描述文件\n获取绑定机器码设备" closeButtonTitle:nil duration:nil];
                
                
            });
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"udid"];
        }
    }else{
        ASIdentifierManager *as = [ASIdentifierManager sharedManager];
//        UDID= as.advertisingIdentifier.UUIDString;
        UDID= [UIDevice VKKeychainIDFV];
        if ([YZ000 containsString:@"YES"]) {
            if ([UDID containsString:@"0000-000"]) {
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor=[UIColor systemGreenColor];
                [alert addButton:@"退出" actionBlock:^{
                    exit(0);
                }];
                
                [alert showError:@"机器码错误" subTitle:@"未获取到正常机器码" closeButtonTitle:nil duration:nil];
                
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
            NSString *nowDateStr = [dateStr stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            param[@"date"] = nowDateStr;
            param[@"md5"] = @"";
            param[@"mutualkey"] = BSPHP_MUTUALKEY;
            param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"km"];
            param[@"icpwd"] = @"";
            param[@"key"] = [NSObject getIDFA];
            param[@"maxoror"] = [NSObject getIDFA];
            [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject)
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
                            [NSObject CodeConfig];
                        });
                    }
                }
            } failure:^(NSError *error)
             {
                
            }];
        });
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
@end




