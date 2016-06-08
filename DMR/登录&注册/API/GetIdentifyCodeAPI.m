//
//  GetIdentifyCodeAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "GetIdentifyCodeAPI.h"
#import "APIRequestProtocol.h"

#define GetIdentifyCode @"user/getCode.do?"

@interface GetIdentifyCodeAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) int source;
@property (nonatomic, strong) NSString *internationalNo;

@end
@implementation GetIdentifyCodeAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:GetIdentifyCode];
}

- (void)startRequestWithMobile:(NSString *)mobile
                        source:(int)source
                      internationalNo:(NSString *)internationalNo {
    _mobile = mobile;
    _source = source;
    _internationalNo = internationalNo;
    [self startRequestUsingPara:@{@"mobile":_mobile,
                                  @"source":@(_source),
                                  @"internationalNo":_internationalNo}];
}

@end
