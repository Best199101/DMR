//
//  TweetCommentModel.m
//  happigo
//
//  Created by fei on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "TweetCommentModel.h"

@implementation TweetCommentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"parentId":@"parentId",
             @"updateTime":@"updateTime",
             @"isPraise":@"isPraise",
             @"uid":@"uid",
             @"_id":@"_id",
             @"pic":@"pic",
             @"topicId":@"topicId",
             @"ismaster":@"ismaster",
             @"parentUid":@"parentUid",
             @"location":@"location",
             @"headurl":@"headurl",
             @"praise":@"praise",
             @"deviceId":@"deviceId",
             @"createTime":@"createTime",
             @"nickname":@"nickname",
             @"deleteFlag":@"deleteFlag",
             @"content":@"content"
             };
}

@end
