//
//  TweetListAPI.m
//  DMR
//
//  Created by shklxmac111 on 15/12/22.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetListAPI.h"

#define TweetList @"http://test.app.dameiren.com/cy/index.do"

@implementation TweetListAPI

-(NSString*)APIReqeustURL
{
    return TweetList;
}

-(NSString*)APIHTTPMethod
{
    return POSTHTTPMethod;
}

@end
