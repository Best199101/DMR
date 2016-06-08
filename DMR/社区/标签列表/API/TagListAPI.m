//
//  TagListAPI.m
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TagListAPI.h"
#import "APIRequestProtocol.h"

#define TagList @"new/cy/tags.do?type=%d&isHost=%d"

@interface TagListAPI ()<APIRequestProtocol>

@property (assign,nonatomic) int type;
@property (assign,nonatomic) int isHost;

@end
@implementation TagListAPI

#pragma mark - APIRequestProtocol的required方法

- (NSString *)APIReqeustURL {
    return [NSString stringWithFormat:TagList,_type,_isHost];
}

- (NSString *)APIHTTPMethod {
    return GETHTTPMethod;
}

#pragma mark - 公有方法

- (void)startRequestWithType:(int)type andIsHost:(int)isHost {
    _type = type;
    _isHost = isHost;
    [self startRequestUsingPara:nil];
}

@end
