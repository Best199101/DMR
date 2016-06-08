
//
//  PersonLevelModel.m
//  happigo
//
//  Created by fei on 16/3/2.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonLevelModel.h"

@implementation PersonLevelModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"_id":@"id",
             @"level":@"level",
             @"update_time":@"update_time",
             @"level_key":@"level_key",
             @"create_time":@"create_time",
             @"experience_from":@"experience_from",
             @"experience_to":@"experience_to",
             @"level_description":@"level_description"
             };
}



@end
