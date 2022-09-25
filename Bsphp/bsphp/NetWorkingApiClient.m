//
//  NetWorkingApiClient.m
//  BSPHPOC
//
//  Created by MRW on 2016/12/14.
//  Copyright © 2016年 xiaozhou. All rights reserved.
//

#import "NetWorkingApiClient.h"
static NetWorkingApiClient *netWorkingClient = nil;
@implementation NetWorkingApiClient
+ (NetWorkingApiClient *)__attribute__((optnone))sharedNetWorkingApiClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkingClient = [[NetWorkingApiClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        netWorkingClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //设置返回原生状态数据：返回NSData类型
        netWorkingClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        //返回的数据是解析完的json数据
        //netWorkingClient.responseSerializer = [AFJSONResponseSerializer serializer];
        //返回的数据是解析完的XML数据
        //netWorkingClient.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
    });
    return netWorkingClient;
}

@end
