//
//  PraiseTweetAPI.m
//  happigo
//
//  Created by shklxmac111 on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "PraiseTweetAPI.h"

#define PraiseTweet @"new/cy/praise/topic.do?uid=%@&targetTopicId=%@&targetUid=%@"

@interface PraiseTweetAPI ()

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *targetTopicId;
@property (strong,nonatomic) NSString *targetUid;

@end

@implementation PraiseTweetAPI

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:PraiseTweet,_uid,_targetTopicId,_targetUid];
}

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(void)startRequestWithUid:(NSString *)uid
             TargetTopicId:(NSString *)targetTopicId
                 TargetUid:(NSString *)targetUid
{
    _uid = uid;
    _targetTopicId = targetTopicId;
    _targetUid = targetUid;
    [self startRequestUsingPara:nil];
}
@end
