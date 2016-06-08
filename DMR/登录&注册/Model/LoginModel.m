//
//  LoginModel.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginModel.h"
#import "LoginUserInfoModel.h"

@implementation LoginModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uid":@"data.uid",
             @"bindMobile":@"data.bindMobile",
             @"userInfo":@"data.userInfo"
             };
}

+ (NSValueTransformer *)bindMobileJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BindMobileModel class]];
}

+ (NSValueTransformer *)userInfoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LoginUserInfoModel class]];
}

@end

@implementation BindMobileModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uid":@"uid",
             @"international_no":@"international_no",
             @"bind_mobile_no":@"bind_mobile_no"
             };
}

@end
