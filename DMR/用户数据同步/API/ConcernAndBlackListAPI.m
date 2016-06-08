//
//  ConcernAndBlackListAPI.m
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "ConcernAndBlackListAPI.h"

#define ConcernAndBlackList @"new/cy/myConcernAndBlackList.do?uid=%@&createtime=%@"

@interface ConcernAndBlackListAPI ()

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSNumber *createTime;

@end

@implementation ConcernAndBlackListAPI

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:ConcernAndBlackList,_uid,_createTime];
}

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(void)startRequestWithUid:(NSString *)uid CreateTime:(NSNumber *)createTime
{
    _uid = uid;
    _createTime = createTime;
    [self startRequestUsingPara:nil];
}

@end
