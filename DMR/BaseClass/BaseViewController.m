//
//  BaseViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/4.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseViewController.h"
#import "ColorTools.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [ColorTools backgroundWhiteColor];
    self.view = view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//    {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
}

- (void)didReceiveMemoryWarning {
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
