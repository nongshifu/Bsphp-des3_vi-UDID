//
//  NSString+URLCode.h
//  LOL
//
//  Created by 刘清 on 16/3/10.
//  Copyright (c) 2016年 LQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLCode)
//编码 string code -> url code
- (NSString *)__attribute__((optnone))URLEncodedString;
//解码 url code -> string code
- (NSString *)__attribute__((optnone))URLDecodedString;

 /**
  md5加密

  @param input 输入要加密的
  @return 输出加密后
  */
- (NSString *)__attribute__((optnone)) md5:(NSString *) input;
@end
