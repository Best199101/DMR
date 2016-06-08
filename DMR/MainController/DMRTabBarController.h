//
//  DMRTabBarController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/4.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "LiPushHandler.h"

@interface DMRTabBarController : UITabBarController

@property (strong, nonatomic) LiPushHandler *pushHandler;
@property (assign, nonatomic) BOOL tabBarHidden;
@property (strong, nonatomic) User *currentUser;
+ (DMRTabBarController *)tabBar;

@end
