//
//  OfficialAnnouncementModel.m
//  happigo
//
//  Created by shklxmac111 on 16/1/3.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "OfficialAnnouncementModel.h"
#import "BannerModel.h"

@implementation OfficialAnnouncementModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"banners":@"data.banners"
             };
}

+ (NSValueTransformer *)bannersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BannerModel class]];
}

@end
