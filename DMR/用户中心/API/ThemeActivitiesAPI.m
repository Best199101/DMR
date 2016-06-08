//
//  ThemeActivitiesAPI.m
//  happigo
//
//  Created by fei on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "ThemeActivitiesAPI.h"

#define ThemeActivities @"new/user/getThematicActivities.do?pageNum=%d"


@interface ThemeActivitiesAPI ()



@end


@implementation ThemeActivitiesAPI

-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:ThemeActivities,_page];
}

-(void)startRequestWithPageNum:(int)page{
    _page = page;
    [self startRequestUsingPara:nil];
}

@end
