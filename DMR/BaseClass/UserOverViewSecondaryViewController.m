//
//  UserOverViewSecondaryViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/11.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UserOverViewSecondaryViewController.h"
#import "UIViewController+NoBackTitle.h"
#import "UIViewController+MMDrawerController.h"

@interface UserOverViewSecondaryViewController ()<NoBackTitleProtocol>

@end

@implementation UserOverViewSecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有代理

-(void)backBarButtonItemClicked
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                      animated:YES
                                    completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
