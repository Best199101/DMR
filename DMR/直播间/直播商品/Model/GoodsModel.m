//
//  GoodsModel.m
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
                @"pTitle":@"pTitle",
                @"pUrl":@"pUrl",
                @"pPic":@"pPic",
                @"pPrice":@"pPrice",
            };
}

@end
