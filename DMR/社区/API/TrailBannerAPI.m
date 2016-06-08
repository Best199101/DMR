//
//  TrailBannerAPI.m
//  happigo
//
//  Created by shklxmac111 on 16/1/11.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "TrailBannerAPI.h"

#define TrailBanner @"new/cy/trial/banners.do?channelcode="

@implementation TrailBannerAPI

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return TrailBanner;
}

-(void)startRequest
{
    [self startRequestUsingPara:nil];
}

@end
