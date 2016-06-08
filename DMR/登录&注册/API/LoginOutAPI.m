//
//  LoginOutAPI.m
//  happigo
//
//  Created by 雨 on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginOutAPI.h"
#import "APIRequestProtocol.h"

#define LoginOut @"user/logout.do"

@interface LoginOutAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *uid;

@end

@implementation LoginOutAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:LoginOut];
}

- (void)startRequestWithUid:(NSString *)uid {
    _uid = uid;
    [self startRequestUsingPara:@{@"uid":_uid}];
}

@end
