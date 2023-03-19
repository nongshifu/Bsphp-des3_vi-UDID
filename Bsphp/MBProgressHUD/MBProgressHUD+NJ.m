//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD+NJ.h"
#define successimg @"iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAYAAAByDd+UAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAZ5JREFUeNrMljFLw0AUx9sMQkFo3Apd4lQQAnXPkEU/RxwzibND6TfQxeKU7u03cLDQD6CTY+rQXUuhQpfzH3kJ4XG53OW0+IffkMvl/XmXd++uLYRoaagDLogz0KXxDXgDT8RXbaTMUEEPPICdqNeO5vZUMVVmt2ArzLWlb7UNO2Am7DWjWErDI7AUv6clxSw8HPZLH0HQaqYpOCGmNBZQTGnRRBaZrIBbiuWy9xFf0mOwtjCM2K/hhmvyKJY0Bv2GS7koLWGua/bcJ48iw9Qiu5Bl54EPybw0z9AHpxaFsmBjI+BK5mYevmNRlZ9gzMZCECm+CTLDQUPDO/AuyU6lgVNqxCbKjO7ZWEQZqtR1aia8ElxjWtJcrkZ2P3LoiJHpBpwTVxrbwNPw22RlHFeUO++zkeE2kCnOPvArXnoS06FkLDHYs75q47+w/igjNDBLy61tIlnvIXiu+Scjg8qelFubqnknFdmZnC5F89YNkEhOg1WT08SkABIycg0LJflXV4w9uATzlr3mFGuvey892DXxTy/C7UNf9b8FGADvi3oYmveiPgAAAABJRU5ErkJggg=="
#define errorimg @"iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAYAAAByDd+UAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAARVJREFUeNrEljsKg0AQhnWLgBDQ0hsIAY+Re2jpAaxyj7Sb3iOk9A4BGysvIIIpJ7MwCbJkH6Lu/vA12cl8iY/ZDQEgsEiEXIkLEtPnI/JCnsTb2EkINaTIHZnBnJlqU11PneyGTLA+E33XWhghDWxPQ720whPSwn5pqadSyGH/cJWwgONSyMIzMih+XUJww7/Q1Q3k+AlrRaPE4pJzqSZR9KqXwt5SKEv5n3WVsP8Kc9sbLkl1a6rkoqBa85QZMD3lFcPplhmmX4Fwi3nLqVaXjC0G8RapjUwkZoHjMNpiTHkgpWa9pBpTRiHsNsrWSDsvr4XzF9/LaHM+vJ1vT142YC9HDOeHKC/HxEMPwqHro/5HgAEA49JgVVm9Og0AAAAASUVORK5CYII="
@implementation MBProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view HideTime:(float)hideTime
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    // 设置图片
    static NSData *data;
    if ([icon containsString:@"success.png"]) {
        data = [[NSData alloc] initWithBase64EncodedString:successimg options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    if ([icon containsString:@"error"]) {
        data = [[NSData alloc] initWithBase64EncodedString:errorimg options:NSDataBase64DecodingIgnoreUnknownCharacters];;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    if (hideTime==0) {
        // 1秒之后再消失
        [hud hide:YES afterDelay:9999];
    }else{
        [hud hide:YES afterDelay:hideTime];
    }
    
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success HideTime:(float)hideTime
{
    [self showSuccess:success toView:nil HideTime:hideTime];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view HideTime:(float)hideTime
{
    [self show:success icon:@"success.png" view:view HideTime:hideTime];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error HideTime:(float)hideTime
{
    [self showError:error toView:nil  HideTime:hideTime];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view HideTime:(float)hideTime{
    [self show:error icon:@"error.png" view:view HideTime:hideTime];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message HideTime:(float)hideTime
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    return hud;
}
/**
 *  显示普通信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showText:(NSString *)message HideTime:(float)hideTime
{
    return [self showText:message toView:nil HideTime:hideTime];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showText:(NSString *)message toView:(UIView *)view HideTime:(float)hideTime{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    if (hideTime==0) {
        // 1秒之后再消失
        [hud hide:YES afterDelay:9999];
    }else{
        [hud hide:YES afterDelay:hideTime];
    }
    return hud;
}
/**
 *  显示下载圆饼
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showYuanBing:(NSString *)message jd:(float)jd
{
    return [self showYuanBing:message toView:nil jd:(float)jd];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showYuanBing:(NSString *)message toView:(UIView *)view jd:(float)jd{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.detailsLabelText =message;
    hud.userInteractionEnabled = YES;
    hud.progress = jd;
    
    return hud;
}
/**
 *  显示下载进度条
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showJindutiao:(NSString *)message jd:(float)jd
{
    return [self showJindutiao:message toView:nil jd:(float)jd];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showJindutiao:(NSString *)message toView:(UIView *)view jd:(float)jd{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.detailsLabelText =message;
    hud.userInteractionEnabled = YES;
    hud.progress = jd;
    
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

@end
