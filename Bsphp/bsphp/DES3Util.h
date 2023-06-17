//
//  DES3Util.h
//  BSPHPOC
//  BSPHP 魔改UDID 技术团队 十三哥工作室
//  承接软件APP开发 UDID定制 验证加密二改 PHP JS HTML5开发 辅助开发
//  WX:NongShiFu123 QQ350722326
//  Created by MRW on 2022/11/14.
//  GitHub:http://github.com/nongshifu/
//  开源Q群: 398423911
//  Copyright © 2019年 xiaozhou. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface DES3Util : NSObject {
}
// 加密方法
+ (NSString*)__attribute__((optnone))encrypt:(NSString*)plainText gkey:(NSString *)gkey;
// 解密方法
+ (NSString*)__attribute__((optnone))decrypt:(NSString*)encryptText gkey:(NSString *)gkey;

@end

#import <Foundation/Foundation.h>

//@interface DES3Util : NSObject

//@end
