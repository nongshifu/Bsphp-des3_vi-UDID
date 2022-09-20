//
//  DES3Util.h
//  TestDes
//
//  BSPHP网络验证系统 Bsphp.Com
//  Copyright © 2016年 Craftsman. All rights reserved.
//
//
//  DES3Util.h
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
