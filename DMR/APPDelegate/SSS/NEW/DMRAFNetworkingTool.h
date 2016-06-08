//
//  DMRAFNetworkingTool.h
//  DMR
//
//  Created by 雨 on 16/6/1.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface DMRAFNetworkingTool : NSObject

+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSString *error))failure;

+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void(^)(id responseObject))success
     failure:(void(^)(NSString *error))failure;

@end

@interface DMRAFNetworkingManager : AFHTTPSessionManager

+ (instancetype)dmrManager;

@end