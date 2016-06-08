//
//  AppDelegate+NavBar.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+NavBar.h"

@implementation AppDelegate (NavBar)

- (void)dmr_NavBarAttributes {
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:RGB(51, 51, 51, 1.0),
                                                           NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light" size:16]
                                                           }];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"Nav_Shadow"]];
    [[UIBarButtonItem appearance] setTintColor:RGB(128, 128, 128, 1.0)];
}

@end
