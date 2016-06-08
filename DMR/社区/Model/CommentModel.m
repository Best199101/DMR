//
//  CommentModel.m
//  happigo
//
//  Created by shklxmac111 on 15/12/28.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentList

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"data":@"data"
             };
}

+(NSValueTransformer *)dataJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CommentModel class]];
}

@end

@implementation CommentModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"commendId":@"_id",
             @"content":@"content",
             @"deleteFlag":@"deleteFlag",
             @"deviceId":@"deviceId",
             @"headUrl":@"headUrl",
             @"isPraise":@"isPraise",
             @"location":@"location",
             @"nickname":@"nickname",
             @"parentId":@"parentId",
             @"parentUid":@"parentUid",
             @"pic":@"pic",
             @"praise":@"praise",
             @"topicId":@"topicId",
             @"uid":@"uid",
             @"updateTime":@"updateTime"
             };
}

+ (NSValueTransformer*)locationJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *location) {
        if (location == nil || [location isEqual:[NSNull null]])
            return @"";
        else
            return location;
    }];
}

+ (NSValueTransformer*)headUrlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *headUrl) {
        if (headUrl == nil || [headUrl isEqual:[NSNull null]])
            return @"";
        else
            return headUrl;
    }];
}

+ (NSValueTransformer*)nicknameJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *nickname) {
        if (nickname == nil || [nickname isEqual:[NSNull null]])
            return @"";
        else
            return nickname;
    }];
}

+ (NSValueTransformer*)parentUidJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *parentUid) {
        if (parentUid == nil || [parentUid isEqual:[NSNull null]])
            return @"";
        else
            return parentUid;
    }];
}

@end
