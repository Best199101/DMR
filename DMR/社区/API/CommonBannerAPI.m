//
//  CommonBannerAPI.m
//  happigo
//
//  Created by shklxmac111 on 15/12/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "CommonBannerAPI.h"

#define CommonBanner @"new/cy/info.do?channelcode="

@interface CommonBannerAPI ()


@end

@implementation CommonBannerAPI

-(NSString*)APIReqeustURL
{
    return [NSString stringWithFormat:CommonBanner];
}

-(NSString*)APIHTTPMethod
{
    return POSTHTTPMethod;
}

-(void)startRequest
{
    [self startRequestUsingPara:nil];
}


@end
