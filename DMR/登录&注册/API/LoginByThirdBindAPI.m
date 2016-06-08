//
//  LoginByThirdBindAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginByThirdBindAPI.h"
#import "APIRequestProtocol.h"

#define LoginByThirdBind @"user/thirdBind.do"

@interface LoginByThirdBindAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *authUid;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *authId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *regSource;
@property (nonatomic, strong) NSString *clientid;

@end
@implementation LoginByThirdBindAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:LoginByThirdBind];
}

- (void)startRequestWithAuthUid:(NSString *)authUid
                      authToken:(NSString *)authToken
                         authId:(NSString *)authId
                       deviceId:(NSString *)deviceId
                      regSource:(NSString *)regSource
                       clientid:(NSString *)clientid {
    _authUid = authUid;
    _authToken = authToken;
    _authId = authId;
    _deviceId = deviceId;
    _regSource = regSource;
    _clientid = clientid;
    [self startRequestUsingPara:@{@"authUid":_authId,
                                  @"authToken":_authToken,
                                  @"authId":_authId,
                                  @"regSource":_regSource,
                                  @"clientid":_clientid}];
}

@end
