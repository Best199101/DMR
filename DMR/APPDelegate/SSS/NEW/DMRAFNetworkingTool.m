//
//  DMRAFNetworkingTool.m
//  DMR
//
//  Created by 雨 on 16/6/1.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import "DMRAFNetworkingTool.h"
#import "NSString+PhoneNumber.h"

static NSString *const DMRRequestBaseURL = @"";

@implementation DMRAFNetworkingTool

+ (void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    
    [[DMRAFNetworkingManager dmrManager] GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([error.domain stringByAppendingString:error.description]);
        }
    }];
    
}

+ (void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    
    [[DMRAFNetworkingManager dmrManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([error.domain stringByAppendingString:error.description]);
        }
    }];
    
}

@end

@implementation DMRAFNetworkingManager

+ (instancetype)dmrManager {
    static DMRAFNetworkingManager *__manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        __manager = [[DMRAFNetworkingManager alloc]initWithBaseURL:[NSURL URLWithString:DMRRequestBaseURL]];
        __manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    return __manager;
}

@end