//
//  FindViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "FindViewController.h"
#import "FindNewViewController.h"
#import "FindHotViewController.h"
#import "FindAttentionViewController.h"
#import "CAPSPageMenu.h"
#import "UIColor+HEX.h"
#import "UIDefine.h"
#import "AdvertisementViewController.h"

@interface FindViewController ()<CAPSPageMenuDelegate>

@property (strong,nonatomic) CAPSPageMenu *pageMenu;

@end

@implementation FindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发现";
    [self initSubViewControllers];
    
    AdvertisementViewController *adver = [[AdvertisementViewController alloc] init];
    [self addChildViewController:adver];
    [self.view addSubview:adver.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 私有方法

-(void)initSubViewControllers
{
    FindNewViewController       *newController       = [FindNewViewController new];
    FindHotViewController       *hotController       = [FindHotViewController new];
    FindAttentionViewController *attentionController = [FindAttentionViewController new];
    newController.title       = @"最新";
    hotController.title       = @"最热";
    attentionController.title = @"关注";
    NSArray *controllerArray = @[newController,hotController,attentionController];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0.97 green:0.4 blue:0.2 alpha:1],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithHex:0xeeebeb],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:15.0f],
                                 CAPSPageMenuOptionMenuHeight: @(30),
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
