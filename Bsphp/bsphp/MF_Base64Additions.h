//
//  MF_Base64Additions.h
//  Base64 -- RFC 4648 compatible implementation
//  see http://www.ietf.org/rfc/rfc4648.txt for more details
//
//  Designed to be compiled with Automatic Reference Counting
//
//  Created by Dave Poirier on 2012-06-14.
//  Public Domain
//  Hosted at https://github.com/ekscrypto/Base64
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Addition)
+(NSString *)__attribute__((optnone))stringFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))stringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)__attribute__((optnone))base64String;
-(NSString *)__attribute__((optnone))base64UrlEncodedString;
@end

@interface NSData (Base64Addition)
+(NSData *)__attribute__((optnone))dataWithBase64String:(NSString *)base64String;
+(NSData *)__attribute__((optnone))dataWithBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)__attribute__((optnone))base64String;
-(NSString *)__attribute__((optnone))base64UrlEncodedString;
@end

@interface MF_Base64Codec : NSObject 
+(NSData *)__attribute__((optnone))dataFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))base64StringFromData:(NSData *)data;
+(NSString *)__attribute__((optnone))base64UrlEncodedStringFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
@end
