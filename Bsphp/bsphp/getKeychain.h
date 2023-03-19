//
//  GIKeychain.h
//  GIKeychainDemo
//
//  Created by shen on 15/12/24.
//  Copyright © 2015年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define accessGroupItem @"XXXXX.GrassInfoAppFamily"

@interface getKeychain : NSObject

+ (id)getKeychainDataForKey:(NSString *)key;
+ (void)addKeychainData:(id)data forKey:(NSString *)key;
+ (void)removeKeychainDataForKey:(NSString *)key;
+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key;

@end
