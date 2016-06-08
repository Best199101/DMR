//
//  NSArray+toString.m
//  happigo
//
//  Created by shklxmac111 on 16/1/5.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "NSMutableArray+toString.h"
#import "SayToStringModel.h"

@implementation NSMutableArray (toString)

-(NSString *)toString
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    if (self.count > 0) {
        for (id obj in self)
        {
            if ([obj isKindOfClass:[NSString class]])
            {
                [string appendFormat:@"%@;",obj];
            }
            else if ([obj isKindOfClass:[SayToStringModel class]])
            {
                [string appendFormat:@"%@;",((SayToStringModel*)obj).uid];
            }
            else if ([obj isKindOfClass:[NSDictionary class]])
            {
                if (![obj[@"name"] isEqualToString:@"0"]) {
                    [string appendFormat:@"%@;",obj[@"name"]];
                }
            }
        }
        [string deleteCharactersInRange:NSMakeRange(string.length - 1 , 1)];
        
    }
    return string;
}

@end
