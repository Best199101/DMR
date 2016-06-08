//
//  NSArray+Order.m
//  happigo
//
//  Created by Coir on 15/5/12.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "NSArray+Order.h"

@implementation NSArray (Order)

- (NSArray *)getOrderedArray    {
    return  [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
}

@end
