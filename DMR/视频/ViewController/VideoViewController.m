//
//  VideoViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoNewViewController.h"
#import "VideoHotViewController.h"
#import "VideoAttentionViewController.h"
#import "CAPSPageMenu.h"
#import "UIColor+HEX.h"
#import "UIDefine.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#import "LiveGoodsGuideViewController.h"
#import "GoodsModel.h"

@interface VideoViewController ()<CAPSPageMenuDelegate>

@property (strong,nonatomic) CAPSPageMenu *pageMenu;

@end

@implementation VideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"视频";
    VideoNewViewController       *newController       = [VideoNewViewController new];
    VideoHotViewController       *hotController       = [VideoHotViewController new];
    VideoAttentionViewController *attentionController = [VideoAttentionViewController new];
    newController.title       = @"最新";
    hotController.title       = @"最热";
    attentionController.title = @"关注";
    NSArray *controllerArray = @[newController,hotController,attentionController];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1],
                                 CAPSPageMenuOptionSelectionIndicatorColor:[UIColor colorWithRed:0.97 green:0.4 blue:0.2 alpha:1],
                                 CAPSPageMenuOptionBottomMenuHairlineColor:[UIColor colorWithHex:0xeeebeb],
                                 CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:15.0f],
                                 CAPSPageMenuOptionMenuHeight: @(30.0),
                                 CAPSPageMenuOptionCenterMenuItems:@(YES),
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
