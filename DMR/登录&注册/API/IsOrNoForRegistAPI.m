//
//  IsOrNoForRegistAPI.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "IsOrNoForRegistAPI.h"
#import "APIRequestProtocol.h"

#define IsOrNoForRegist @"user/isReg.do"

@interface IsOrNoForRegistAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *account;

@end
@implementation IsOrNoForRegistAPI

- (NSString *)APIHTTPMethod {
    return POSTHTTPMethod;
}

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:IsOrNoForRegist];
}

- (void)startRequestWithAccount:(NSString *)account {
    _account = account;
    [self startRequestUsingPara:@{@"account":_account}];
}

@end
