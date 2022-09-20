//
//  LRKeychain.m
//  LazyReader
//  qq
//
//  Created by Yi on 2018/7/15.
//

#import "LRKeychain.h"

#define Key_User_PhoneNumber @"cn.reader.phoneNumber"
#define Key_User_Password @"cn.reader.password"

@implementation LRKeychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(id)kSecClass,// 标识符(kSecAttrGeneric通常值位密码)
            service, (__bridge id)kSecAttrService,// 服务(kSecAttrService)
            service, (__bridge id)kSecAttrAccount,// 账户(kSecAttrAccount)
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,// kSecAttrAccessiblein变量用来指定这个应用何时需要访问这个数据
            nil];
}

+ (void)addKeychainData:(id)data forKey:(NSString *)key {
    // 获取查询字典
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    // 在删除之前先删除旧数据
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    // 添加新的数据到字典
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    // 将数据字典添加到钥匙串
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)getKeychainDataForKey:(NSString *)key {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery: key];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
            
        }
    }
    
    return ret;
}

+ (void)deleteKeychainDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery: key];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}



@end
