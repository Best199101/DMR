
//
//  PersonLevelAPI.m
//  happigo
//
//  Created by fei on 16/3/2.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonLevelAPI.h"

#define PersonLevel @"new/user/getLeveInfo.do?level=%d"


@interface PersonLevelAPI ()

@property(nonatomic, assign) int level;

@end



@implementation PersonLevelAPI

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:PersonLevel,_level];
}

-(void)startRequestWithLevel:(int)level{
    _level = level;
    [self startRequestUsingPara:nil];
}




@end
