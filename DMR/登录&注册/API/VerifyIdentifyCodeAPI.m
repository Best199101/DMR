//
//  VerifyIdentifyCodeAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "VerifyIdentifyCodeAPI.h"
#import "APIRequestProtocol.h"

#define VerifyIdentify @"user/checkCode.do"

@interface VerifyIdentifyCodeAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) int source;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *deviceId;

@end
@implementation VerifyIdentifyCodeAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:VerifyIdentify];
}

- (void)startRequestWithMobile:(NSString *)mobile
                        source:(int)source
                          code:(NSString *)code
                      deviceId:(NSString *)deviceId {
    _mobile = mobile;
    _source = source;
    _code = code;
    _deviceId = deviceId;
    [self startRequestUsingPara:@{@"mobile":_mobile,
                                  @"source":@(_source),
                                  @"code":_code}];
}

@end
