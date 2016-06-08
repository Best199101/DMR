//
//  LoginUserInfoModel.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LoginUserInfoModel.h"

@implementation LoginUserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uid":@"uid",
             @"nickname":@"nickname",
             @"head_img_url":@"head_img_url",
             @"sex":@"sex",
             @"age":@"age",
             @"country":@"country",
             @"province":@"province",
             @"city":@"city",
             @"level":@"level",
             @"experience":@"experience",
             @"jfNo":@"jfNo",
             @"gold":@"gold",
             @"is_master":@"is_master",
             @"create_time":@"create_time",
             @"birthday":@"birthday",
             @"_description":@"description",
             @"district":@"district",
             @"isAdmin":@"isAdmin",
             @"open_video":@"open_video"
             };
}

@end
