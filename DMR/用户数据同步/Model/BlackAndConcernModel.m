//
//  BlackAndConcernModel.m
//  happigo
//
//  Created by fei on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "BlackAndConcernModel.h"

@implementation BlackAndConcernModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"blacklist": @"blacklist",
             @"concernlist": @"concernlist"
             };
}


@end

