//
//  PostTweetAPI.m
//  happigo
//
//  Created by 李海龙 on 15/12/31.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "PostTweetAPI.h"


#define PostTweet @"new/cy/add/topic.do"

@interface PostTweetAPI ()<APIRequestProtocol>

@property (nonatomic, strong) NSString *uid; 
@property (nonatomic, strong) NSString *title; 
@property (nonatomic, strong) NSString *content; 
@property (nonatomic, strong) NSString *tags; 
@property (nonatomic, strong) NSString *pic; 
@property (nonatomic, strong) NSString *location; 
@property (nonatomic, strong) NSString *ats;

@end

@implementation PostTweetAPI

#pragma mark - APIRequestProtocol的required方法
- (NSString*)APIReqeustURL{
    return [NSString stringWithFormat:PostTweet];
}
- (NSString*)APIHTTPMethod;{
    return POSTHTTPMethod;
}

#pragma mark 公有方法
-(void)startRequestWithUid:(NSString *)uid
                     Title:(NSString *)title
                   Content:(NSString *)content
                      Tags:(NSString *)tags
                       Pic:(NSString *)pic
                  Location:(NSString *)location
                       Ats:(NSString *)ats{
    _uid = uid;
    _title = title;
    _content = content;
    _tags = tags;
    _pic = pic;
    _location = location;
    _ats = ats;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithCapacity:0];
    if (_uid.length > 0)
    {
        [parameters setValue:_uid forKey:@"uid"];
    }
    if (_title.length > 0)
    {
        [parameters setValue:_title forKey:@"title"];
    }
    if (_content.length > 0)
    {
        [parameters setValue:_content forKey:@"content"];
    }
    if (_tags.length > 0)
    {
        [parameters setValue:_tags forKey:@"tags"];
    }
    if (_pic.length > 0)
    {
        [parameters setValue:_pic forKey:@"pic"];
    }
    if (_location.length > 0)
    {
        [parameters setValue:_location forKey:@"location"];
    }
    if (_ats.length > 0) {
        [parameters setValue:_ats forKey:@"ats"];
    }
    
    [self startRequestUsingPara:parameters];
}
@end
