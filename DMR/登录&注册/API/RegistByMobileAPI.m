//
//  RegistByMobileAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "RegistByMobileAPI.h"
#import "APIRequestProtocol.h"

#define RegistByMobile @"user/regByMobile.do"

@interface RegistByMobileAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) int regSource;
@property (nonatomic, strong) NSString *devieceId;

@end
@implementation RegistByMobileAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:RegistByMobile];
}

- (void)startRequestWithMobile:(NSString *)mobile
                      password:(NSString *)password
                          code:(NSString *)code
                     regSource:(int)regSource
                      deviceId:(NSString *)deviceId {
    _mobile = mobile;
    _password = password;
    _code = code;
    _regSource = regSource;
    _devieceId = deviceId;
    
//    ?mobile=%@&password=%@&code=%@&regSource=%d
    [self startRequestUsingPara:@{@"mobile":_mobile,
                                  @"password":_password,
                                  @"code":_code,
                                  @"regSource":@(_regSource)}];
}

@end
