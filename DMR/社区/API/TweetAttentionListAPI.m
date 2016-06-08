//
//  TweetAttentionListAPI.m
//  happigo
//
//  Created by 李海龙 on 15/12/29.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "TweetAttentionListAPI.h"
#import "APIRequestProtocol.h"

#define TweetAttentionList @"new/cy/concern/list.do?lastTime=%lu&uid=%@"

@interface TweetAttentionListAPI ()<APIRequestProtocol>

@property (nonatomic, assign) long lastTime; //上一次返回数据list中最后一条数据的updateTime。等于空默认获取第一页的数据
@property (nonatomic, strong) NSString *uid	; //用户id
@end

@implementation TweetAttentionListAPI

#pragma mark - APIRequestProtocol的required方法
- (NSString*)APIReqeustURL{
    return [NSString stringWithFormat:TweetAttentionList,_lastTime,_uid];
}
- (NSString*)APIHTTPMethod;{
    return GETHTTPMethod;
}

#pragma mark 公有方法

-(void)startRequestWithLastTime:(long)lastTime uid:(NSString *)uid{
    _lastTime = lastTime;
    _uid = uid;
    [self startRequestUsingPara:nil];
}
@end
