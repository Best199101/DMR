//
//  AtUserModel.m
//  happigo
//
//  Created by shklxmac111 on 16/1/2.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "AtUserModel.h"

@implementation AtUserList

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"data":@"data"
             };
}

+(NSValueTransformer *)dataJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AtUserModel class]];
}


@end

@implementation AtUserModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"uid":@"uid",
                @"nickname":@"nickname",
                @"head_img_url":@"headurl",
                @"ismaster":@"ismaster",
                @"desc":@"description"
            };
}

@end
