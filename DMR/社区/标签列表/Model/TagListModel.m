//
//  TagListModel.m
//  happigo
//
//  Created by 李海龙 on 16/1/1.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TagListModel.h"

@implementation ListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tags":@"tags",
             @"hotTags":@"hotTags"
             };
}

+ (NSValueTransformer *)tagsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TagListModel class]];
}

+ (NSValueTransformer *)hotTagsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TagListModel class]];
}

@end
@implementation TagListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"icon":@"icon",
             @"tag_name":@"tag_name"
             };
}

@end
