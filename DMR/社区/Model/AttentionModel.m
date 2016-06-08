//
//  AttentionModel.m
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "AttentionModel.h"

@implementation AttentionModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"uid":@"uid",
             @"nickname":@"nickname",
             @"headurl":@"headurl",
             @"desc":@"description",
             @"ismaster":@"ismaster"};
}

+ (NSValueTransformer*)headurlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSString *headurl) {
        if (headurl == nil)
            return @"";
        else
            return headurl;
    }];
}
@end
