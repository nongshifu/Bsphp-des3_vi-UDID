//
//  MBProgressHUD+NJ.h
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (NJ)
+ (MBProgressHUD *)showYuanBing:(NSString *)message jd:(float)jd;
+ (MBProgressHUD *)showJindutiao:(NSString *)message jd:(float)jd;
+ (void)showSuccess:(NSString *)success HideTime:(float)hideTime;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view HideTime:(float)hideTime;

+ (void)showError:(NSString *)error HideTime:(float)hideTime;
+ (void)showError:(NSString *)error toView:(UIView *)view HideTime:(float)hideTime;


+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
+ (MBProgressHUD *)showText:(NSString *)message HideTime:(float)hideTime;

@end
