//
//  PersonInfoAPI.m
//  happigo
//
//  Created by fei on 16/2/22.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonInfoAPI.h"


#define PersonInfo @"new/user/getUserInfoByUid.do"


@interface PersonInfoAPI ()

@property(nonatomic, strong) NSString *uid;

@end


@implementation PersonInfoAPI

-(NSString *)APIHTTPMethod
{
    return POSTHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:PersonInfo];
}

-(void)startRequestWithUid:(NSString *)uid{
    _uid = uid;
    [self startRequestUsingPara:@{@"uid":_uid}];
}

@end
