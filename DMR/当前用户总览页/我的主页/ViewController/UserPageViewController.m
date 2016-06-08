//
//  UserPageViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/11.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UserPageViewController.h"

@interface UserPageViewController ()

@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
