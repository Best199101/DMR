//
//  AdvertisementAPI.m
//  DMR
//
//  Created by 李海龙 on 15/12/22.
//  Copyright © 2015年 wangzitao. All rights reserved.
//

#import "AdvertisementAPI.h"

#define Advertisement @"advert/get.do"

@implementation AdvertisementAPI

-(NSString *)APIReqeustURL
{
    return Advertisement;
}

-(NSString *)APIHTTPMethod
{
    return POSTHTTPMethod;
}

-(void)startRequestWithParameters:(NSDictionary *)parameters
{
    [self startRequestUsingPara:parameters];
}

@end
