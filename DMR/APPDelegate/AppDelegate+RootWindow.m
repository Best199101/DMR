//
//  AppDelegate+RootWindow.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+RootWindow.h"
//#import "WelcomeViewController.h"
//#import "adViewController.h"

#import "MMDrawerController.h"
#import "UINavigationBar+Normal.h"
#import "UserOverviewViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@implementation AppDelegate (RootWindow)

//- (void)dmr_RootViewController {
//    
//    //趣看界面视适配，判断机型
//    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (Screen_height > 480) {
//        myDelegate.autoSizeScaleX = Screen_width/375;
//        myDelegate.autoSizeScaleY = Screen_height/667;
//    }else{
//        myDelegate.autoSizeScaleX = 0.85333333;
//        myDelegate.autoSizeScaleY = 0.85157421;
//    }
//    
//    //tabbar页面的创建
//    LiTabbarController *mainTabVC = [LiTabbarController tabBar];
//    mainTabVC.backGroundBlock = ^{   };
//    mainTabVC.foreGroundBlock = ^{   };
//    
//    //欢迎页和广告页
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    self.nav = [[LiNavVC alloc] initWithRootViewController:mainTabVC];
//    
//    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:[NSBundle mainBundle]];
//    adViewController *adVC = [[adViewController alloc] initWithNibName:@"adViewController" bundle:[NSBundle mainBundle]];
//    self.window.rootViewController = self.nav;
//    if ([UserDefault boolForKey:@"isFirstUse"])
//    {
//        [self.nav pushViewController:adVC animated:NO];
//    }
//    else
//    {
//        [self.nav pushViewController:welcomeVC animated:NO];
//    }
//    
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//}

- (void)dmr_RootViewControllerWithIsSlip:(BOOL)isSlip {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.DMRMainController = [DMRTabBarController new];

    if (isSlip) {
        UINavigationController *mainNavigationController = [[UINavigationController alloc]initWithRootViewController:self.DMRMainController];
        [mainNavigationController.navigationBar setNormalStyle];
        
        MMDrawerController *mmDrawerController = [[MMDrawerController alloc]
                                                  initWithCenterViewController:mainNavigationController
                                                  leftDrawerViewController:[UserOverviewViewController new]];
        [mmDrawerController setShowsShadow:YES];
        [mmDrawerController setRestorationIdentifier:@"MMDrawer"];
        [mmDrawerController setMaximumRightDrawerWidth:Screen_width];
        [mmDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [mmDrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [mmDrawerController
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block;
             block = [[MMExampleDrawerVisualStateManager sharedManager]
                      drawerVisualStateBlockForDrawerSide:drawerSide];
             if(block){
                 block(drawerController, drawerSide, percentVisible);
             }
         }];
        self.window.rootViewController = mmDrawerController;
    } else {
        self.window.rootViewController = self.DMRMainController;
    }
    
    [self.window makeKeyAndVisible];
    
}

@end
