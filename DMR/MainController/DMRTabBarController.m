//
//  DMRTabBarController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/4.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "DMRTabBarController.h"
#import "BaseNavigationController.h"
#import "LiveRoomViewController.h"
#import "VideoViewController.h"
#import "FindViewController.h"
#import "TweetViewController.h"
#import "ShopViewController.h"
#import "UINavigationBar+Normal.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIBarButtonItem+Badge.h"
#import "UserCenterViewController.h"


@interface DMRTabBarController ()
{
    LiveRoomViewController      *_liveRoomViewController;
    VideoViewController         *_videoViewController;
    FindViewController          *_findViewController;
    TweetViewController         *_tweetViewController;
    ShopViewController          *_shopViewController;
    UserCenterViewController    *_userCenterViewController;
}

@end

@implementation DMRTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSubViewControllers];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)initSubViewControllers
{
    _liveRoomViewController   = [LiveRoomViewController new];
    _videoViewController      = [VideoViewController new];
    _findViewController       = [FindViewController new];
    _tweetViewController      = [TweetViewController new];
    _shopViewController       = [ShopViewController new];
    _userCenterViewController = [UserCenterViewController new];
    self.viewControllers    = @[
                                [self addNavigationItemForViewController:_liveRoomViewController],
                                [self addNavigationItemForViewController:_videoViewController],
                                [self addNavigationItemForViewController:_findViewController],
                                [self addNavigationItemForViewController:_tweetViewController],
                                [self addNavigationItemForViewController:_userCenterViewController]
                              ];
    NSArray *titles         = @[@"直播间",@"视频",@"发现",@"社区",@"个人中心"];
    NSArray *images         = @[@"liveRoom",@"video",@"find",@"tweet",@"shop"];
    [self tabBarConfigure];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item,
                                                    NSUInteger idx,
                                                    BOOL *stop) {
        UIImage *image = [[UIImage imageNamed:images[idx]]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *seletedImage =
        [[UIImage imageNamed:[images[idx]stringByAppendingString:@"Select"]]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitle:titles[idx]];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                       NSForegroundColorAttributeName:[UIColor colorWithRed:251.0/255 green:113.0/255 blue:76.0/255 alpha:1]}
                            forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                       NSForegroundColorAttributeName:[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1]}
                            forState:UIControlStateNormal];
        [item setImage:image];
        [item setSelectedImage:seletedImage];
    }];
}

#pragma mark - 私有代理

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法

- (void)tabBarConfigure
{
    self.tabBar.backgroundImage = nil;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.translucent = NO;
}

-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                      animated:YES
                                    completion:nil];
}

-(void)rightBarButtonPress:(id)sender
{
    
}


- (BaseNavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
{
    
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:viewController];
//    [navigationController.navigationBar setNormalStyle];
    if ([viewController isKindOfClass:[LiveRoomViewController class]]
      ||[viewController isKindOfClass:[VideoViewController class]]
      ||[viewController isKindOfClass:[FindViewController class]]
      ||[viewController isKindOfClass:[TweetViewController class]])
    {
        [viewController.navigationItem setLeftBarButtonItem:self.leftMenuButton];
        [viewController.navigationItem setRightBarButtonItem:self.rightMenuButton];
    }
    else if ([viewController isKindOfClass:[ShopViewController class]])
    {
        [viewController.navigationItem setLeftBarButtonItem:self.leftMenuButton];
    }
    
    return navigationController;
}

-(MMDrawerBarButtonItem *)leftMenuButton
{
    MMDrawerBarButtonItem *leftBarButton =
    [[MMDrawerBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"userOverView"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                          style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(leftDrawerButtonPress:)];
    return leftBarButton;
}

-(UIBarButtonItem *)rightMenuButton
{
    UIBarButtonItem *rightBarButton =
    [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(rightBarButtonPress:)];
    return rightBarButton;
}



@end
