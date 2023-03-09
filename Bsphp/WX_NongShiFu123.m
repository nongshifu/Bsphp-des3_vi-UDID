//
//  ViewController.m
//  BSPHPOC
//  BSPHP 魔改UDID 技术团队 十三哥工作室
//  承接软件APP开发 UDID定制 验证加密二改 PHP JS HTML5开发 辅助开发
//  WX:NongShiFu123 QQ350722326
//  Created by MRW on 2022/11/14.
//  Copyright © 2019年 xiaozhou. All rights reserved.
//
#import <AdSupport/AdSupport.h>
#import "Config.h"
#import "WX_NongShiFu123.h"
#import "UIDevice+VKKeychainIDFV.h"
#import "LRKeychain.h"
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import "GIKeychain.h"
#import "NSString+MD5.h"
#import "Config.h"
#import "SCLAlertView.h"
#import "MBProgressHUD+NJ.h"
#import <QuickLook/QuickLook.h>
@interface WX_NongShiFu123 ()
@property (nonatomic,strong) NSDictionary * baseDict;
@end
NSString*软件版本号,*软件公告,*软件描述,*软件网页地址,*软件url地址,*逻辑A,*逻辑B,*免费模式;
bool 验证状态,过直播开关;
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
//    [GIKeychain addKeychainData:@"2222222222" forKey:@"ShiSanGeUDID"];
//    [[WX_NongShiFu123 alloc] BSPHP];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"公告"];
}
NSString* 到期时间弹窗,*UDID_IDFV,*验证版本,*验证过直播,*弹窗类型,*验证公告,*到期时间;
- (void)BSPHP{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getBSphpSeSsL:^{
            [self getXinxi:^{
                if ([验证公告 containsString:@"YES"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"公告"];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(BS延迟启动时间 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([UDID_IDFV containsString:@"YES"]) {
                        [self getUDID:^{
                            [self YZTC:@"请输入激活码"];
                        }];
                    }else{
                        [self getIDFV:^{
                            [self YZTC:@"请输入激活码"];
                        }];
                        
                    }
                });
                
            }];
            
        }];
    });
    
   
    
}
- (void)YZTC:(NSString*_Nullable)string
{
    //NSLog(@"激活码弹窗");
    NSString*km=[GIKeychain getKeychainDataForKey:@"ShiSanGeKM"];
    if (km.length>2) {
        //NSLog(@"激活码弹窗KM=%@",km);
        [self yanzhengAndUseIt:km];
    }else{
        if ([弹窗类型 containsString:@"YES"]) {
            //系统弹窗
            UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:string preferredStyle:UIAlertControllerStyleAlert];
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
                //NSLog(@"输入框1：%@", textField1.text);
                if (textField1.text.length ==0 ) {
                    //NSLog(@"输入框内容为空");
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

        }else{
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
            
        }
    }
    
}
/**
 获取本次打开的BSphpSeSsL 作为在线判断
 */
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
        //NSLog(@"BSphpSeSsL获取失败=%@",error);
    }];
    
}

/**
 软件信息
 */
- (void)getXinxi:(void (^)(void))completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"globalinfo.in";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];
    param[@"date"] = [self getSystemDate];
    param[@"mutualkey"] = BSPHP_MUTUALKEY;
    param[@"appsafecode"] = appsafecode;//这里是防封包被劫持的验证，传什么给服务器返回什么，返回不一样说明中途被劫持了
    param[@"md5"] = @"";
    param[@"info"] = @"GLOBAL_V|GLOBAL_GG|GLOBAL_MIAOSHU|GLOBAL_WEBURL|GLOBAL_URL|GLOBAL_LOGICINFOA|GLOBAL_LOGICB|GLOBAL_CHARGESET";
    [NetTool Post_AppendURL:BSPHP_HOST parameters:param success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dict) {
            软件信息=dict[@"response"][@"data"];
            NSArray *arr = [软件信息 componentsSeparatedByString:@"|"];
            软件版本号=arr[0];
            软件公告=arr[1];
            软件描述=arr[2];
            软件网页地址=arr[3];
            软件url地址=arr[4];
            逻辑A=arr[5];
            逻辑B=arr[6];
            免费模式=arr[7];
//            NSLog(@"软件信息 ==%@",软件信息);
            NSArray *arr2 = [软件描述 componentsSeparatedByString:@"\n"];
            到期时间弹窗=arr2[0];
            UDID_IDFV=arr2[1];
            验证版本=arr2[2];
            验证过直播=arr2[3];
            弹窗类型=arr2[4];
            验证公告=arr2[5];
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
        //NSLog(@"getMiao获取失败=%@",error);
    }];
    
}
/**
 心跳定期验证 查询卡串状态 到期 冻结 删除 等
 */
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
                NSLog(@"验证正常：%@",DRBool);
                [self getXinxi:^{
                    验证状态=YES;
                    
                }];
            }else if ([DRBool containsString:@"5030"]) {
                NSLog(@"验证到期：%@",DRBool);
                [self YZTC:[NSString stringWithFormat:@"卡密到期-到期时间\n%@",到期时间]];
                验证状态=NO;
                //NSLog(@"用户在线中-返回：%@",DRBool);
            }else if ([DRBool containsString:@"1085"]) {
                NSLog(@"验证冻结：%@",DRBool);
                [self YZTC:@"卡密被冻结"];
                验证状态=NO;
                //NSLog(@"用户在线中-返回：%@",DRBool);
            }else if ([DRBool containsString:@"1079"]) {
                NSLog(@"被迫下线：%@",DRBool);
                [self showText:@"被迫下线" message:@"卡密在其他设备APP登录\n设备数量-在线APP超过限制" Exit:NO];
                验证状态=YES;
                
            }else{
                验证状态=NO;
                NSLog(@"验证失败-状态码：%@",DRBool);
                [self YZTC:[NSString stringWithFormat:@"验证失败-状态码\n%@",DRBool]];
            }
            
        }
    } failure:^(NSError *error) {
    }];
}

/**
 定期验证 查询卡串状态 到期 冻结 删除 等
 */
- (void)getDeng{
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
            NSString*DRBool = dict[@"response"][@"data"];
            if ([DRBool containsString:@"1080"]) {
                验证状态=YES;
                //NSLog(@"用户在线中-返回：%@",DRBool);
            }else{
                验证状态=NO;
                //NSLog(@"用户不在在线-返回：%@",DRBool);
            }
           
        }
    } failure:^(NSError *error) {
    }];
}
/**
 加载公告 API
 */
- (void)getGongGao:(void (^)(void))completion {
    
    //判断-软件后台-公告弹窗为YES 那就每次启动App 判断和本地储存的公告不同就弹公告
    if ([验证公告 containsString:@"YES"]&& 验证状态) {
        [self ggtc];
    }
    //判断-软件后台-公告弹窗为NO 那就只判断和本地储存的公告不同就弹公告
    if ([验证公告 containsString:@"NO"]&& 验证状态){
        [self ggtc];
    }
    
    else{
//        NSLog(@"公告获取成功");
        if (completion) {
            completion();
        }
    }
}
- (void)ggtc
{
    NSString*本地公告=[[NSUserDefaults standardUserDefaults] objectForKey:@"公告"];
    if ([本地公告 isEqual:软件公告])return;
    //发生更新才弹
    if ([弹窗类型 containsString:@"YES"]) {
        //系统弹窗
        UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:软件公告 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];
        [rootViewController presentViewController:alert animated:YES completion:nil];
        
    }else{
        //SCL弹窗
        SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
        alert.customViewColor=[UIColor systemGreenColor];
        alert.shouldDismissOnTapOutside = NO;
        [alert showQuestion:@"公告" subTitle:软件公告 closeButtonTitle:@"确定" duration:5];
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:软件公告 forKey:@"公告"];
    
}

/**
获取版本号
*/
- (void)getVV:(void (^)(void))completion {
    if ([验证版本 containsString:@"YES"] && ![软件版本号 isEqual:JN_VERSION]) {
        验证状态=NO;
        //提示版本更新
        if ([弹窗类型 containsString:@"YES"]) {
            //系统弹窗
            UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"发现新版" preferredStyle:UIAlertControllerStyleAlert];
            
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

        }else{
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
            
        }
        
    }else{
//        NSLog(@"版本验证通过");
        if (completion) {
            completion();
        }
    }
    
}
/**
 验证使用
 */
- (void)yanzhengAndUseIt:(NSString*)km{
    //参数开始组包
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *appsafecode = [self getSystemDate];//设置一次过期判断变量
    param[@"api"] = @"login.ic";
    param[@"BSphpSeSsL"] = self.baseDict[@"response"][@"data"];//ssl是获取的全局参数，app第一次启动时候获取的
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
                //NSLog(@"2");
                dict[@"response"][@"data"] = @"-2000";
            }
            
            NSString *dataString = dict[@"response"][@"data"];
            NSRange range = [dataString rangeOfString:@"|1081|"];
            if (range.location != NSNotFound) {
                //验证成功
                NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                if (arr.count >= 6)
                {
                    //NSLog(@"验证成功=%@",dataString);
                    到期时间=arr[4];
                    [GIKeychain addKeychainData:km forKey:@"ShiSanGeKM"];
                    if (!验证状态) {
                        //每次启动都弹出
                        if ([到期时间弹窗 containsString:@"YES"]) {
                            [self showText:@"验证成功-到期时间" message:arr[4] Exit:NO];
                        }else{
                            BOOL 判断是否已经弹窗过=[[NSUserDefaults standardUserDefaults] boolForKey:@"到期弹窗"];
                            //仅仅首次激活弹窗
                            if (!判断是否已经弹窗过) {
                                [self showText:@"验证成功-到期时间" message:arr[4] Exit:NO];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"到期弹窗"];
                            }
                            
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
                    });
                    
                }
            }else{
                //NSLog(@"dataString=%@",dataString);
                [GIKeychain addKeychainData:@"" forKey:@"ShiSanGeKM"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"到期弹窗"];
                //验证失败
                [self YZTC:dataString];
                
            }
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

//获取时间
- (NSString *)getSystemDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    dateFormatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}
//获取设备码
- (void)getUDID:(void (^)(void))completion
{
    //读取本地UDID
    设备特征码=[GIKeychain getKeychainDataForKey:@"ShiSanGeUDID"];
    //NSLog(@"ShiSanGeUDID=%@",设备特征码);
    //如果钥匙串没有UDID 折通过用户id去读取服务器获取
    if (设备特征码.length<5 || 设备特征码==nil || 设备特征码==NULL) {
        //不存在就读取服务器安装描述文件获取
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
        suijiid=[GIKeychain getKeychainDataForKey:@"suijiid"];
        //NSLog(@"suijiid=%@",suijiid);
        //不存在就储存随机生成id并且储存钥匙串
        if (suijiid<=0) {
            int a =arc4random() % 100000;
            suijiid=[NSString stringWithFormat:@"%d",a];
            [GIKeychain addKeychainData:suijiid forKey:@"suijiid"];
            //NSLog(@"生成随机ID=%d",a);
        }
        //通过ID读取服务器的UDID
        NSString *requestStr = [NSString stringWithFormat:@"%@udid%@.txt",UDID_HOST,suijiid];
        //NSLog(@"requestStr=%@",requestStr);
        // 创建 NSURLSession 对象
        NSURLSession *session = [NSURLSession sharedSession];
        // 创建 NSURL 对象
        NSURL *url = [NSURL URLWithString:requestStr];
        // 创建 NSURLSessionDataTask 对象
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                // URL 返回错误
                //NSLog(@"URL 返回错误：%@", error);
                [self showText:@"UDID获取错误" message:[NSString stringWithFormat:@"%@",error] Exit:YES];
            } else {
                // URL 正常
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if ([httpResponse statusCode] == 404) {
                    //NSLog(@"URL 返回 404 错误 提示用户安装UDID描述文件");
                    //如果有错误 证明服务器没有 那就安装描述文件获取
                    NSString*url=[NSString stringWithFormat:@"%@udid.php?id=%@&openurl=%@",UDID_HOST,suijiid,urlSchemes];
                    //NSLog(@"URL 地址：%@", url);
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //跳转浏览器后退出程序
                        exit(0);
                    });
                    
                } else {
                    //NSLog(@"URL 正常");
                    // 打印返回值非404的html字符串
                    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    //NSLog(@"URL 返回的 HTML 字符串：%@", htmlString);
                    //删除换行和空格
                    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                    设备特征码 = [htmlString stringByTrimmingCharactersInSet:whitespace];
                    //如果没有错误 储存UDID到钥匙串
                    [GIKeychain addKeychainData:设备特征码 forKey:@"ShiSanGeUDID"];
                    if (completion) {
                        completion();
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
- (void)getIDFV:(void (^)(void))completion
{
    //优先读取钥匙串 保证同一个App的多开读取到同一个IDFV
    设备特征码=[GIKeychain getKeychainDataForKey:@"ShiSanGeIDFV"];
    if (设备特征码==NULL || 设备特征码.length<5 ) {
        //钥匙串没有就读取当前App的IDFA 并且储存为统一钥匙串
        设备特征码=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        //储存
        [GIKeychain addKeychainData:设备特征码 forKey:@"ShiSanGeIDFV"];
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
-(void)showText:(NSString* _Nullable)Title message:(NSString* _Nullable)message Exit:(BOOL)Exit
{
    if ([弹窗类型 containsString:@"YES"]) {
        //系统弹窗
        UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 确定操作
            if(Exit){
                exit(0);
            }
        }];
        [alert addAction:okAction];
        
        [rootViewController presentViewController:alert animated:YES completion:nil];

    }else{
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
        
    }
}
@end
