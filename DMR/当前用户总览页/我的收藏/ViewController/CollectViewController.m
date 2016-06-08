//
//  CollectViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/11.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectFindViewController.h"
#import "CollectTweetViewController.h"
#import "CollectVideoViewController.h"
#import "CAPSPageMenu.h"
#import "UIColor+HEX.h"
#import "UIDefine.h"

@interface CollectViewController ()<CAPSPageMenuDelegate>

@property (strong,nonatomic) CAPSPageMenu *pageMenu;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    CollectVideoViewController  *videoController       = [CollectVideoViewController new];
    CollectFindViewController   *findController        = [CollectFindViewController  new];
    CollectTweetViewController  *tweetController       = [CollectTweetViewController new];
    videoController.title = @"视频";
    findController.title  = @"文章";
    tweetController.title = @"问答";
    NSArray *controllerArray = @[videoController,findController,tweetController];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0.97 green:0.4 blue:0.2 alpha:1],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithHex:0xeeebeb],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:15.0f],
                                 CAPSPageMenuOptionMenuHeight: @(30.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionMenuMargin:@(0),
                                 CAPSPageMenuOptionMenuItemWidth:@(DeviceWidth/3),
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor colorWithHex:0x000000],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor colorWithHex:0x979797],
                                 };
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray
                                                        frame:CGRectMake(0,0,DeviceWidth,DeviceHeight)
                                                      options:parameters];
    _pageMenu.delegate = self;
    [self.view addSubview:_pageMenu.view];
    MenuItemView *menuFirst = self.pageMenu.menuItems.firstObject;
    menuFirst.titleLabel.font = [UIFont systemFontOfSize:16.0f];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有代理

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
