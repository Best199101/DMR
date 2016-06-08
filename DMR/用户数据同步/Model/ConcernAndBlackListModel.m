//
//  ConcernAndBlackListModel.m
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "ConcernAndBlackListModel.h"
#import "Global.h"

@implementation ConcernAndBlackListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"createtime":@"data.createtime",
             @"blacklist":@"data.blacklist",
             @"concernlist":@"data.concernlist"
             };
}

+(NSValueTransformer *)currentuidJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *currentuid) {
        currentuid = UserId;
        return currentuid;
    }];
}

+(NSValueTransformer *)concernlistJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ConcernAndBlackModel class]];
}

+(NSValueTransformer *)blacklistJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ConcernAndBlackModel class]];
}


@end

@implementation ConcernAndBlackModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid":@"uid",
             @"level":@"level",
             @"nickname":@"nickname",
             @"headurl":@"headurl",
             @"ismaster":@"ismaster"
             };
}

@end

