//
//  UINavigationBar+Normal.m
//  HealthBracelets
//
//  Created by JacobMao on 14-8-13.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "UINavigationBar+Normal.h"

@implementation UINavigationBar (Normal)
- (void)setNormalStyle
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    [self setTintColor:[UIColor blackColor]];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                              NSFontAttributeName:[UIFont systemFontOfSize:17]
                                   }];
    self.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end
