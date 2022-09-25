
//
//  NetWorkingApiClient.h
//  BSPHPOC
//
//  Created by MRW on 2016/12/14.
//  Copyright © 2016年 xiaozhou. All rights reserved.
//

#import "AFNetworking.h"

@interface NetWorkingApiClient : AFHTTPSessionManager
+ (NetWorkingApiClient *)sharedNetWorkingApiClient;
@end
