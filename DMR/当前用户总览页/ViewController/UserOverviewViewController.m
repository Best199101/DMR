//
//  UserOverviewViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UserOverviewViewController.h"
#import "Global.h"
#import "UserOverViewCell.h"
#import "UserOverHeadView.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "DMRTabBarController.h"
#import "UIResponder+Router.h"

#import "BroadCastViewController.h"
#import "NoticeViewController.h"
#import "EditUserProfileViewController.h"
#import "MyShoppingViewController.h"
#import "UserPageViewController.h"
#import "CollectViewController.h"
#import "AttentViewController.h"
#import "SettingViewController.h"

@interface UserOverviewViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UserOverHeadView *headView;
@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) NSArray *imageArray;
@property (strong,nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation UserOverviewViewController

-(void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"大美人广播",
                   @"我的通知",
                   @"编辑个人资料",
                   @"我的商城",
                   @"我的主页",
                   @"我的收藏",
                   @"我的关注"];
    _imageArray = @[@"broadcast",
                    @"notice",
                    @"edit",
                    @"myshopping",
                    @"home",
                    @"collection",
                    @"attention"];
    [self initSubViews];
    [self setLayouts];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有

-(void)initSubViews
{
    [self.view addSubview:self.tableView];
}

-(void)setLayouts
{
    __weak typeof(self) weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
}

#pragma mark - 接受事件分发处理

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if ([eventName isEqualToString:UserOverHeadViewLeftButtonTapped])
    {
        EditUserProfileViewController *viewController = [EditUserProfileViewController new];
        [delegate.DMRMainController.navigationController pushViewController:viewController
                                                                   animated:NO];
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                          animated:YES
                                        completion:nil];

        
    }
    else if ([eventName isEqualToString:UserOverHeadViewRightButtonTapped])
    {
        SettingViewController *viewController = [SettingViewController new];
        [delegate.DMRMainController.navigationController pushViewController:viewController
                                                                   animated:NO];
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                          animated:YES
                                        completion:nil];


    }
}

#pragma mark - 代理

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"userOverViewCell";
    UserOverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UserOverViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.textLabel.text  = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                      animated:YES
                                    completion:nil];
    UserOverViewSecondaryViewController *viewController;
    switch (indexPath.row)
    {
        case 0:
            viewController = [BroadCastViewController new];
            break;
        case 1:
            viewController = [NoticeViewController new];
            break;
        case 2:
            viewController = [EditUserProfileViewController new];
            break;
        case 3:
            viewController = [MyShoppingViewController new];
            break;
        case 4:
            viewController = [UserPageViewController new];;
            break;
        case 5:
            viewController = [CollectViewController new];
            break;
        case 6:
            viewController = [AttentViewController new];
            break;
        default:
            break;
    }
    if (viewController)
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.DMRMainController.navigationController pushViewController:viewController
                                                                   animated:NO];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 属性

-(UITableView *)tableView
{
    if (nil == _tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero
                                                 style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.tableFooterView = [UIView new];
        [_tableView setRowHeight:50];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

-(UserOverHeadView *)headView
{
    if (_headView == nil)
    {
        _headView = [UserOverHeadView new];
        _headView.frame = CGRectMake(0, 0, DeviceWidth, DeviceWidth/2 + 40);
    }
    return _headView;
}



@end
