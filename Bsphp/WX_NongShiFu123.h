//
//  ViewController.h
//  BSPHPOC
//
//  Created by MRW on 2016/12/14.
//  Copyright © 2016年 xiaozhou. All rights reserved.
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

