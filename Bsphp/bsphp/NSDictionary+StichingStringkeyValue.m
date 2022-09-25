//
//  NSDictionary+StichingStringkeyValue.m
//  BSPHPOC
//
//  Created by MRW on 2016/12/28.
//  Copyright © 2016年 xiaozhou. All rights reserved.
//

#import "NSDictionary+StichingStringkeyValue.h"

@implementation NSDictionary (StichingStringkeyValue)
/**
 将字典拼接成URL形式并以字符串返回
 
 @param dictionary 参数字典
 @return 字符串形式返回
 */
+ (NSString *)__attribute__((optnone))stitchingStringFromDictionary:(NSDictionary *)dictionary{
    NSMutableString *str = [[NSMutableString alloc]initWithCapacity:10];
    bool first = YES;
    for (NSString *key in dictionary)
    {
        if (first)
        {
            [str appendString:[NSString stringWithFormat:@"%@=%@",key,[dictionary objectForKey:key]]];
            first = !first;
        }else
        {
            
            [str appendString:[NSString stringWithFormat:@"&%@=%@",key,[dictionary objectForKey:key]]];
        }
    }
    return str;
}
@end
