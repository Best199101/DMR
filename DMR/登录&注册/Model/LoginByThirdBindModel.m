//
//  LoginByThirdBindModel.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginByThirdBindModel.h"
#import "LoginUserInfoModel.h"

@implementation LoginByThirdBindModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uid":@"uid",
             @"userInfo":@"userInfo"
             };
}

+ (NSValueTransformer *)userInfoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LoginUserInfoModel class]];
}

@end
