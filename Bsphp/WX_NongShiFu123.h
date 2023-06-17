//
//  ViewController.h
//  BSPHPOC
//  BSPHP 魔改UDID 技术团队 十三哥工作室
//  承接软件APP开发 UDID定制 验证加密二改 PHP JS HTML5开发 辅助开发
//  WX:NongShiFu123 QQ350722326
//  Created by MRW on 2022/11/14.
//  GitHub:http://github.com/nongshifu/
//  开源Q群: 398423911
//  Copyright © 2019年 xiaozhou. All rights reserved.
//
#import <QuickLook/QuickLook.h>
#import <UIKit/UIKit.h>

extern NSString*软件版本号,*软件公告,*软件描述,*软件网页地址,*软件url地址,*逻辑A,*逻辑B,*解绑扣除时间,*试用模式;
extern bool 验证状态,过直播开关;
extern NSString*设备特征码;
extern NSString*到期时间;
extern NSString*软件信息;
@interface WX_NongShiFu123 : UIAlertController<UIAlertViewDelegate>
- (void)BSPHP;
@property (strong, nonatomic) NSMutableData *receivedData;
@end

