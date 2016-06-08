//
//  PersonSignAPI.m
//  happigo
//
//  Created by fei on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//


#define PersonSign @"new/user/signIn.do?uid=%@"


#import "PersonSignAPI.h"



@interface PersonSignAPI ()

@property(nonatomic, strong) NSString *uid;


@end



@implementation PersonSignAPI


-(NSString *)APIHTTPMethod
{
    return GETHTTPMethod;
}

-(NSString *)APIReqeustURL
{
    return [NSString stringWithFormat:PersonSign,_uid];
}

-(void)startRequestWithUid:(NSString *)uid{
    _uid = uid;
    [self startRequestUsingPara:nil];
}


@end
