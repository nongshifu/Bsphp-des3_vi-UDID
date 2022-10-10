//
//  ViewController.h
//  Radar
//
//  Created by 十三哥 on 2022/8/19.
//

#import "QQ350722326.h"
#import "LRKeychain.h"
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

#import "NSString+MD5.h"
#import "Config.h"

#import <AdSupport/ASIdentifierManager.h>
#import "MBProgressHUD.h"
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
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
                [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                NSDate *date = [NSDate date];
                NSTimeZone * zone = [NSTimeZone systemTimeZone];
                NSInteger interval = [zone secondsFromGMTForDate:date];
                NSDate * nowDate = [date dateByAddingTimeInterval:interval];
                NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
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
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                                        hud.mode = MBProgressHUDModeText;
                                        hud.detailsLabel.text = @"授权错误，机器码不正确\n联系管理员解绑或更换卡密";;
                                        hud.userInteractionEnabled = NO;
                                        [hud hideAnimated:YES afterDelay:3];
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [self processActivate];
                                        });
                                    });
                                    
                                    
                                }else{
                                    if ([DQTC containsString:@"YES"]) {
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            NSString *showMsg = [NSString stringWithFormat:@"授权成功,到期时间\n %@", arr[4]];
                                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                                            hud.mode = MBProgressHUDModeText;
                                            hud.detailsLabel.text =showMsg;
                                            hud.userInteractionEnabled = YES;
                                            [hud hideAnimated:YES afterDelay:3];
                                        });
                                       
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
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.detailsLabel.text = dataString;
                                hud.userInteractionEnabled = NO;
                                [hud hideAnimated:YES afterDelay:3];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self processActivate];
                                });
                            });
                            
                            
                        }
                    }
                } myfailure:^(NSError *error)
                 {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.detailsLabel.text = [NSString stringWithFormat:@"%@",error];;
                        hud.userInteractionEnabled = NO;
                        [hud hideAnimated:YES afterDelay:5];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self processActivate];
                        });
                    });
                    
                }];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                               {
                    [NSObject processActivate];
                });
            }
            
        }
    } myfailure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
            [NSObject processActivate];
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                NSString *version = dict[@"response"][@"data"];
                BOOL result = [version isEqualToString:localv];
                if (!result){
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"请更新新版,5秒后跳转下载";
                    hud.userInteractionEnabled = NO;
                    [hud hideAnimated:YES afterDelay:5];
                    NSString*url=[NSObject getnew];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            exit(0);
                        });
                    });
                }
            }
        } myfailure:^(NSError *error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"网络链接失败";
            hud.userInteractionEnabled = NO;
            [hud hideAnimated:YES afterDelay:3.5f];
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
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
        [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        param[@"BSphpSeSsL"] = [dateStr MD5Digest];
        NSDate *date = [NSDate date];
        NSTimeZone * zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        NSDate * nowDate = [date dateByAddingTimeInterval:interval];
        NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
        param[@"date"] = nowDateStr;
        param[@"md5"] = @"";
        param[@"mutualkey"] = BSPHP_MUTUALKEY;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NetTool Post_AppendURL:BSPHP_HOST myparameters:param mysuccess:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {
                    NSString *message = dict[@"response"][@"data"];
                    if (message.length>2 ) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.detailsLabel.text =message;
                            hud.userInteractionEnabled = NO;
                            [hud hideAnimated:YES afterDelay:5.5f];
                        });
                    }
                }
            } myfailure:^(NSError *error) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabel.text =@"网络链接失败";
                hud.userInteractionEnabled = NO;
                [hud hideAnimated:YES afterDelay:3.5f];
                
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
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            exit(0);
//        });
//    });
//
    NSString *CONFIRM = @"激活";
    NSString *CANCEL = @"购买";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"验证激活" delegate:self cancelButtonTitle:CANCEL otherButtonTitles:CONFIRM, nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    txtName.placeholder = @"请输入激活码";
//    txtName.borderStyle = UITextBorderStyleRoundedRect;
    txtName.clearButtonMode = UITextFieldViewModeAlways;
    txtName.layer.masksToBounds=YES;
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *CONFIRM = @"激活";
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (YES == [btnTitle isEqualToString:CONFIRM])
    {
        UITextField *tf = [alertView textFieldAtIndex:0];
        
        if (nil == tf.text || 0 == tf.text.length)
        {
            [self processActivate];
            return ;
        }
        [NSObject YzCode:tf.text];
       
        
    }
    else
    {
        NSString*url=@"https://docs.qingque.cn/d/home/eZQAHRSyp_qEQuRPiX4TkAXqi?identityId=1r3gqGopOS4";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
        [self processActivate];
    }
    
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
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
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.detailsLabel.text = @"授权错误，机器码不正确\n联系管理员解绑或更换卡密";
                            hud.userInteractionEnabled = NO;
                            [hud hideAnimated:YES afterDelay:3];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self processActivate];
                            });
                        });
                        
                    }else{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            NSString *showMsg = [NSString stringWithFormat:@"授权成功-到期时间\n%@", arr[4]];
                            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.detailsLabel.text =showMsg;
                            hud.userInteractionEnabled = NO;
                            [hud hideAnimated:YES afterDelay:5.0f];
                        });
                        
                    }
                }
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *messageStr = dict[@"response"][@"data"];
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =messageStr;
                    hud.userInteractionEnabled = YES;
                    [hud hideAnimated:YES afterDelay:3];
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
        //请求的url
        UDID=[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"];
        if (UDID.length>10 && ![UDID containsString:@"0000"]) {
            return UDID;
        }
        NSString *requestStr = [NSString stringWithFormat:@"%@udid%ld.txt",UDID_HOST,cc];
        NSError*error;
        UDID = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:&error];
        if (error==nil) {
            [[NSUserDefaults standardUserDefaults] setObject:UDID forKey:@"udid"];
            return UDID;
        }else{
            
            //没读取到就获取描述文件
            NSString*url=[NSString stringWithFormat:@"%@udid.php?id=%ld&openurl=%@",UDID_HOST,cc,urlSchemes];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                exit(0);
            });
            return @"error";
        }
    }else{
        ASIdentifierManager *as = [ASIdentifierManager sharedManager];
        UDID= as.advertisingIdentifier.UUIDString;
        if ([YZ000 containsString:@"YES"]) {
            if ([UDID containsString:@"0000-00"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabel.text =@"IDFA机器码获取失败\n获取到0000-000-000错误";
                hud.userInteractionEnabled = NO;
                [hud hideAnimated:YES afterDelay:99999];
                
            }
        }
    }
    return UDID;
}
-(void)dingshiqi
{
    timer=[NSTimer timerWithTimeInterval:60 repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"api"] = @"login.ic";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
            NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
            param[@"BSphpSeSsL"] = [dateStr MD5Digest];
            NSDate *date = [NSDate date];
            NSTimeZone * zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:date];
            NSDate * nowDate = [date dateByAddingTimeInterval:interval];
            NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
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




