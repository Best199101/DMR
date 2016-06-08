//
//  PraiseUserModel.m
//  happigo
//
//  Created by shklxmac111 on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "PraiseUserModel.h"

@implementation PraiseUserModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"headurl":@"headurl",
             @"uid":@"uid",
             @"nickname":@"nickname",
             @"ismaster":@"ismaster"
             };
}

+ (NSValueTransformer*)headurlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *headurl) {
        if (headurl == nil || [headurl isEqual:[NSNull null]])
            return @"";
        else
            return headurl;
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

@end
