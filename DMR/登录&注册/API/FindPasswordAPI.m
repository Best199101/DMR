//
//  FindPasswordAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "FindPasswordAPI.h"
#import "APIRequestProtocol.h"

#define FindPassword @"user/updatePwd.do"

@interface FindPasswordAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *code;

@end
@implementation FindPasswordAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:FindPassword];
}

- (void)startRequestWithAccount:(NSString *)account
                       password:(NSString *)password
                           code:(NSString *)code {
    _account = account;
    _password = password;
    _code = code;
    [self startRequestUsingPara:@{@"account":_account,
                                  @"password":_password,
                                  @"code":_code}];
}

@end
