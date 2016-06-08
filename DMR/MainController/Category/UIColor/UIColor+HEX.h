//
//  UIColor+HEX.h
//  xiaoqu
//
//  Created by wendy on 15/9/4.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

@end
