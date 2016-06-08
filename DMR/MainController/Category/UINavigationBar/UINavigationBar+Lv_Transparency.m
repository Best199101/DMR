//
//  UINavigationBar+Lv_Transparency.m
//  HealthBracelets
//
//  Created by Steven on 14-8-12.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "UINavigationBar+Lv_Transparency.h"

@implementation UINavigationBar (Lv_Transparency)
- (void)transparency
{
//    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self setShadowImage:[UIImage new]];
//    [self setTintColor:[UIColor whiteColor]];
//    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    [self setTranslucent:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIImage *image = [self imageWithColor:[UIColor clearColor]];
    
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self setBarStyle:UIBarStyleDefault];
    [self setShadowImage:[UIImage new]];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self setTintColor:[UIColor whiteColor]];
    [self setTranslucent:YES];

}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
