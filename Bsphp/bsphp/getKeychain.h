//
//  GIKeychain.h
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

#define accessGroupItem @"XXXXX.GrassInfoAppFamily"

@interface getKeychain : NSObject

+ (id)getKeychainDataForKey:(NSString *)key;
+ (void)addKeychainData:(id)data forKey:(NSString *)key;
+ (void)removeKeychainDataForKey:(NSString *)key;
+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key;

@end
