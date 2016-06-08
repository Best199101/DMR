//
//  CommonBannerModel.m
//  happigo
//
//  Created by shklxjsbmac004 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "CommonBannerModel.h"
#import "BannerModel.h"

@implementation CommonBannerModel

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"banner_left":@"data.banner_left",
             @"banner_right":@"data.banner_right",
             @"broadcast":@"data.broadcast",
             @"banners":@"data.banners"
             };
}

+ (NSValueTransformer *)bannersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BannerModel class]];
}

@end
