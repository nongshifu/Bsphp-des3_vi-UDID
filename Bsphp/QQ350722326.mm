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
#import "SCLAlertView.h"
#import "NSString+MD5.h"
#import "Config.h"
#import "SCLAlertView.h"
#import <AdSupport/ASIdentifierManager.h>

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
                                    [NSObject CodeConfig];
                                    [NSObject showAlertMsg:@"授权错误，机器码不正确\n联系管理员解绑或更换卡密" error:NO];
                                }else{
                                    if ([DQTC containsString:@"YES"]) {
                                        NSString *showMsg = [NSString stringWithFormat:@"授权成功，到期时间\n %@", arr[4]];
                                        SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                                        [alert addTimerToButtonIndex:0 reverse:YES];
                                        [alert showSuccess:nil title:@"授权提示" subTitle:showMsg closeButtonTitle:@"确定" duration:3];
                                    }
                                    //验证版本
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        if([YZBB containsString:@"YES"]){
                                            //验证通过后验证版本 和公告
                                            [NSObject loadbanben];
                                        }
                                    });
                                    //验证公告
                                    static dispatch_once_t onceToken;
                                    dispatch_once(&onceToken, ^{
                                        [NSObject gonggao];//公告
                                    });
                                    //验证通过后在这里启动你的辅助
                                    [NSObject dingshiqi];
                                    
                                }
                            }
                            
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
                } myfailure:^(NSError *error)
                 {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                   {
                        [NSObject CodeConfig];
                    });
                }];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                               {
                    [NSObject CodeConfig];
                });
            }
            
        }
    } myfailure:^(NSError *error) {
        NSLog(@"error=%@",error);
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
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    [alert addButton:@"确定" actionBlock:^{
                        NSString*url=[NSObject getnew];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            exit(0);
                        });
                    }];
                    [alert showWarning:@"温馨提示" subTitle:(@"发现新版本 请更新") closeButtonTitle:nil duration:0.0f];
                }
            }
        } myfailure:^(NSError *error) {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
             [alert addTimerToButtonIndex:0 reverse:YES];
             [alert showWarning:@"温馨提示" subTitle:(@"网络连接失败！请重启应用！") closeButtonTitle:nil duration:0.0f];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
             [alert addTimerToButtonIndex:0 reverse:YES];
             [alert showWarning:@"温馨提示" subTitle:(@"网络连接失败！请重启应用！") closeButtonTitle:nil duration:0.0f];
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
                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                        [alert addTimerToButtonIndex:0 reverse:YES];
                        [alert showWarning:@"公告" subTitle:message closeButtonTitle:@"确定" duration:10.0f];
                    }
                }
            } myfailure:^(NSError *error) {
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert showWarning:@"温馨提示" subTitle:(@"公告信息获取失败请重启应用!") closeButtonTitle:@"确定" duration:0.0f];
            }];
        });
    });
}

/**
 激活弹窗
 */
- (void)CodeConfig
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SCLAlertView *alertx = [[SCLAlertView alloc] initWithNewWindow];
        SCLTextView *evenField = [alertx addTextField:@"请输入或粘贴激活码"];
        [alertx addButton:@"粘贴激活码" validationBlock:^BOOL{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            evenField.text =pasteboard.string;
            return NO;
        }actionBlock:^{}];
        [alertx addButton:@"授权" validationBlock:^BOOL{ if (evenField.text.length == 0)
        {
            SCLAlertView *alertxx = [[SCLAlertView alloc] initWithNewWindow];
            [alertxx showEdit:@"激活码不能为空" subTitle:nil closeButtonTitle:nil duration:2.0f];
            return NO;
        }else{
            [self YzCode:evenField.text finish:nil];
            return YES;
        }
            
        }actionBlock:^{}];
        NSString*udid=[[NSUserDefaults standardUserDefaults] objectForKey:@"udid"];
        NSString *showMsg = [NSString stringWithFormat:@"请输入激活码并点击授权\n%@",udid];
        [alertx showEdit:@"请先授权" subTitle:showMsg closeButtonTitle:nil duration:0.0f];
    });
    
}
/**
 验证逻辑
 */
- (void)YzCode:(NSString *)code finish:(void (^)(NSDictionary *done))finish
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
                    
                    NSString *showMsg = [NSString stringWithFormat:@"到期时间: %@", arr[4]];
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert addButton:@"确定" actionBlock:^{
                        exit(0);
                    }];
                    [alert showEdit:@"验证成功！重启游戏生效" subTitle:showMsg closeButtonTitle:nil duration:0];
                    
                }
            }
            else
            {
                NSString *messageStr = dict[@"response"][@"data"];
                [self CodeConfig];
                [self showAlertMsg:messageStr error:NO];
            }
        }
        else{
            [self CodeConfig];
        }
    } myfailure:^(NSError *error)
     {
        [self CodeConfig];
    }];
}
/**
 提示条
 */
-(void)showAlertMsg:(NSString*)提示 error:(BOOL)是否闪退
{
    SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
    [alert addTimerToButtonIndex:0 reverse:YES];
    [alert addButton:@"确定" actionBlock:^{
        if (是否闪退==YES) {
            exit(0);
        }
    }];
    [alert showError:nil subTitle:提示 closeButtonTitle:nil duration:0];
   
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
                SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
                [alert addButton:@"确定" actionBlock:^{
                    exit(0);
                }];
                [alert showInfo:@"获取机器码失败" subTitle:@"ios13系统：设置-隐私-广告-关闭限制广告跟踪\n\nios14-15系统：设置-隐私-跟踪-开启允许App跟踪\n\n友情提示：请按照以上指引操作！这个是获取机器码操作，并不涉及什么隐私，无需担心！" closeButtonTitle:nil duration:0];
                
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
                            [NSObject CodeConfig];
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




