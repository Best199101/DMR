//
//  TweetTagListAPI.m
//  happigo
//
//  Created by 李海龙 on 16/1/1.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TweetTagListAPI.h"
#import "APIRequestProtocol.h"

#define TweetTagList @"new/cy/searchByTag.do?tagname=%@&lastTime=%ld"

@interface TweetTagListAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *tagname; // 标签名字
@end

@implementation TweetTagListAPI


#pragma mark - APIRequestProtocol的required方法

- (NSString*)APIReqeustURL
{
    return [NSString stringWithFormat:TweetTagList,_tagname,_lasttime];
}
- (NSString*)APIHTTPMethod
{
    return  GETHTTPMethod;
}

#pragma mark 公有方法
-(void)startRequestWithTagname:(NSString *)tagname
                      Lasttime:(long)lasttime{
    _tagname = tagname;
    _lasttime = lasttime;

    [self startRequestUsingPara:nil];
}



@end
