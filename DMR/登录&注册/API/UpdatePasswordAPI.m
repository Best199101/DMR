//
//  UpdatePasswordAPI.m
//  happigo
//
//  Created by 雨 on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "UpdatePasswordAPI.h"
#import "APIRequestProtocol.h"

#define UpdatePassword @"user/updatePwd/new.do"

@interface UpdatePasswordAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *passwordOld;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *deviceId;

@end
@implementation UpdatePasswordAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:UpdatePassword];
}
- (void)startReauestWithAccount:(NSString *)account
                    passwordOld:(NSString *)passwordOld
                       password:(NSString *)password
                       deviceId:(NSString *)deviceId {
    _account = account;
    _passwordOld = passwordOld;
    _password = password;
    _deviceId = deviceId;
    [self startRequestUsingPara:@{@"account":_account,
                                  @"passwordOld":_passwordOld,
                                  @"password":_password}];
}

@end
