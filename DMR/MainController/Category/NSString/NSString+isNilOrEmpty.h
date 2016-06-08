//
//  NSString+isNilOrEmpty.h
//  HealthBracelets
//
//  Created by JacobMao on 14-8-6.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (isNilOrEmpty)
+ (BOOL)isNilOrEmpty:(NSString *)string;
+ (NSString*)emptyString;
- (BOOL)isContainSubString:(NSString*)string;
@end
