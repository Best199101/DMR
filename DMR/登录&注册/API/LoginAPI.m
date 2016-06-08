//
//  LoginAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginAPI.h"
#import "APIRequestProtocol.h"

#define Login @"user/login.do"

@interface LoginAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *mac;
@property (nonatomic, strong) NSString *clientid;

@end
@implementation LoginAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:Login];
}

- (void)startRequestWithAccount:(NSString *)account
                       password:(NSString *)password
                       clientid:(NSString *)clientid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    if (account)
    {
        [parameters setObject:account forKey:@"account"];
    }
    if (password)
    {
        [parameters setObject:password forKey:@"password"];
    }
    if (clientid)
    {
        [parameters setObject:clientid forKey:@"clientid"];
    }
    [self startRequestUsingPara:parameters];
}

@end
