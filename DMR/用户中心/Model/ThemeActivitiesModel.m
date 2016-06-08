//
//  ThemeActivitiesModel.m
//  happigo
//
//  Created by fei on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "ThemeActivitiesModel.h"

@implementation ThemeActivitiesModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"data":@"data"
             };
}

+(NSValueTransformer *)dataJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ActivitiesModel class]];
}


@end



@implementation ActivitiesModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"_id":@"_id",
             @"title":@"title",
             @"pic":@"pic",
             @"bannerTarget":@"bannerTarget",
             @"shareUrl":@"shareUrl",
             @"shareTitle":@"shareTitle",
             @"shareContent":@"shareContent",
             @"sharePic":@"sharePic",
             @"type":@"type",
             @"isPublish":@"isPublish",
             @"deleteFlag":@"deleteFlag",
             @"createTime":@"createTime",
             @"updateTime":@"updateTime",
             @"publishTime":@"publishTime"
             };

}


@end




