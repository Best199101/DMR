//
//  AtUserListAPI.m
//  happigo
//
//  Created by shklxmac111 on 16/1/2.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "AtUserListAPI.h"

#define AtUserList @"new/cy/getRecommendUsers.do"

@implementation AtUserListAPI

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return AtUserList;
}

-(void)startRequest
{
    [self startRequestUsingPara:nil];
}


@end
