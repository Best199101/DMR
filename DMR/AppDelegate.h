//
//  AppDelegate.h
//  DMR
//
//  Created by shklxmac111 on 15/12/1.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SynchronizeManager.h"
@class DMRTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DMRTabBarController *DMRMainController;
@property (strong, nonatomic) SynchronizeManager *synchronizeManager;

//趣看直播界面适配
@property float autoSizeScaleX;
@property float autoSizeScaleY;

@end

