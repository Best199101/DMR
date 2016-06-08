//
//  LiveRoomViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "LiveRoomViewController.h"
#import "LiveListViewController.h"
#import "LiveTrailerViewController.h"
#import "CAPSPageMenu.h"
#import "UIColor+HEX.h"
#import "UIViewController+TopStatus.h"
#import "UIBarButtonItem+Badge.h"
#import "ImagesBrowser.h"
#import "UIDefine.h"
#import "CommentInputBar.h"
#import "ColorTools.h"


#import "UITableView+DMRRefresh.h"

@interface LiveRoomViewController ()<CAPSPageMenuDelegate,CommentInputBarDelegate>

@property (nonatomic, strong) CAPSPageMenu *pageMenu;
@property (nonatomic, strong) CommentInputBar *inputView;

@end

@implementation LiveRoomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    table.backgroundColor = [UIColor redColor];
    table.tag = 9;
    [table addHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
//    [table addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    [self.view addSubview:table];
    
    
}

- (void)refreshHeader {
    UITableView *table = (UITableView *)[self.view viewWithTag:9];
    [table.mj_header endRefreshing];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - 私有代理 

- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index
{
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index
{
}


#pragma mark - 属性



@end
