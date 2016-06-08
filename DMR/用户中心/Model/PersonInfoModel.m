//
//  PersonInfoModel.m
//  happigo
//
//  Created by fei on 16/2/22.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonInfoModel.h"
#import "NSString+StringToValue.h"

@implementation PersonInfoModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nickname":@"data.nickname",
             @"update_time":@"data.update_time",
             @"is_master":@"data.is_master",
             @"experience":@"data.experience",
             @"myFanNum":@"data.myFanNum",
             @"uid":@"data.uid",
             @"qukHostSort":@"data.qukHostSort",
             @"concernNum":@"data.concernNum",
             @"isQukHost":@"data.isQukHost",
             @"age":@"data.age",
             @"birthday":@"data.birthday",
             @"desc":@"data.description",
             @"open_video":@"data.open_video",
             @"jfNo":@"data.jfNo",
             @"level":@"data.level",
             @"sex":@"data.sex",
             @"head_img_url":@"data.head_img_url",
             @"create_time":@"data.create_time",
             @"topicNum":@"data.topicNum",
             @"topicVideoNum":@"data.topicVideoNum",
             @"qukVideoNum":@"data.qukVideoNum",
             @"myHomepage":@"data.myHomepage",
             @"isAdmin":@"data.isAdmin",
             @"isSign":@"data.isSign",
             @"notifyCount":@"data.count"
             };
}

+(NSValueTransformer *)notifyCountJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UnreadNotifyModel class]];
}

+ (NSValueTransformer *)descJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *desc) {        
        
        return [NSString stringToValueWithJSONString:desc];
    }];
}

+ (NSValueTransformer *)head_img_urlJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *head_img_url) {
        
        return [NSString stringToValueWithJSONString:head_img_url];
    }];
}

+ (NSValueTransformer *)nicknameJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *nickname) {
        
        return [NSString stringToValueWithJSONString:nickname];
    }];
}

//
- (NSArray *)personInfoArray {
    NSString *sex = @"神秘";
    if ([_sex isEqual:@"0"]) {
        sex = @"神秘";
    } else if ([_sex isEqual:@"1"]) {
        sex = @"男";
    } else if ([_sex isEqual:@"2"]) {
        sex = @"女";
    } else if ([_sex isEqual:@0]) {
        sex = @"神秘";
    } else if ([_sex isEqual:@1]) {
        sex = @"男";
    } else if ([_sex isEqual:@2]) {
        sex = @"女";
    }
    if (_desc == nil) {
        _desc = @"";
    }
    [NSString stringToValueWithJSONString:_desc];
    [NSString stringToValueWithJSONString:_head_img_url];
    [NSString stringToValueWithJSONString:_nickname];
    _personInfoArray = @[_head_img_url,_nickname,sex,_desc];
    return _personInfoArray;
}

@end

@implementation UnreadNotifyModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"praiseCount":@"praiseCount",
             @"noticeCount":@"noticeCount",
             @"atCount":@"atCount",
             @"commentCount":@"commentCount"
             };
    
}



@end




