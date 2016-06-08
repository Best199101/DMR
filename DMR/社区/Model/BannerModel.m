//
//  BannerModel.m
//  
//
//  Created by shklxjsbmac004 on 15/12/23.
//
//

#import "BannerModel.h"


@implementation BannerModel

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"title":@"title",
             @"pic":@"pic",
             @"bannerTargetType":@"bannerTargetType",
             @"bannerTarget":@"bannerTarget",
             @"bannerChannel":@"bannerChannel",
             @"bannerChannelDesc":@"bannerChannelDesc",
             @"bannerNumber":@"bannerNumber",
             @"shareContent":@"shareContent",
             @"sharePic":@"sharePic",
             @"shareUrl":@"shareUrl",
             @"imgH":@"imgH",
             @"shareTitle":@"shareTitle",
             };
}

@end
