//
//  TweetListAPI.m
//  DMR
//
//  Created by shklxmac111 on 15/12/22.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetListChoiceAPI.h"

#define TweetListChoice @"new/cy/choose/list.do?lastTime=%@"

@interface TweetListChoiceAPI ()


@end

@implementation TweetListChoiceAPI

-(NSString*)APIReqeustURL
{
    return [NSString stringWithFormat:TweetListChoice,_lastTime];
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
