//
//  UIViewController+NoNavBackTitle.m
//  HealthBracelets
//
//  Created by JulianChen on 14-8-4.
//  Copyright (c) 2014年 JulianChen. All rights reserved.
//

#import "UIViewController+NoBackTitle.h"

@implementation UIViewController (NoBackTitle)

-(void)setNavigationBackItem{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"]
                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backBarButtonItemClicked)];
}

- (void)setNavigationItemStyle
{
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
}
@end
