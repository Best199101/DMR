//
//  OfficialTweetListViewController.m
//  happigo
//
//  Created by shklxmac111 on 15/12/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "OfficialTweetListViewController.h"
#import "ColorTools.h"
#import "TweetListModel.h"
#import "TweetListCell.h"
#import "BannerView.h"
#import "TweetTagListAPI.h"
#import "UIResponder+Router.h"
#import <MJRefresh.h>
#import "TweetDetailViewController.h"
#import "AddAttentionAPI.h"
#import "PraiseTweetAPI.h"
#import "TweetTagListViewController.h"
#import "PortraitView.h"
#import "TagView.h"
#import "ShareDetailViewController.h"
#import "OfficialBannerAPI.h"
#import "ConcernAndBlackListModel.h"
#import "CancelAttentionAPI.h"
#import "AppDelegate.h"
#import "OfficialAnnouncementModel.h"
#import "BannerView.h"
#import "BannerPusher.h"
#import "BannerModel.h"
#import "Global.h"

@interface OfficialTweetListViewController ()
<UITableViewDataSource,
UITableViewDelegate,
APIRequestManagerDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) TweetTagListAPI *tweetTagListAPI;
@property (strong,nonatomic) AddAttentionAPI *addAttentionAPI;
@property (strong,nonatomic) PraiseTweetAPI *praiseTweetAPI;
@property (strong,nonatomic) OfficialBannerAPI *officialBannerAPI;
@property (strong,nonatomic) CancelAttentionAPI *cancelAttentionAPI;
@property (strong,nonatomic) BannerView *bannerView;
@property (strong,nonatomic) OfficialAnnouncementModel *model;

@end

@implementation OfficialTweetListViewController

-(void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"大美人活动";
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_top_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                    style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(back)];
    _dataArray = [NSMutableArray new];
    [self.officialBannerAPI startRequest];
    [self.tweetTagListAPI startRequestWithTagname:@"大美人活动"
                                         Lasttime:0];
    [self.view addSubview:self.tableView];
    WeakObject(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
}

#pragma mark - 网络代理

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
}

#pragma mark - 返回

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 列表刷新

-(void)loadMoreData
{
    [self.tweetTagListAPI startRequestWithTagname:@"大美人活动"
                                         Lasttime:_tweetTagListAPI.lasttime];
}

-(void)refreshData
{
    _tweetTagListAPI.lasttime = 0;
    [self.tweetTagListAPI startRequestWithTagname:@"大美人活动"
                                         Lasttime:_tweetTagListAPI.lasttime];
}

#pragma mark - 列表代理

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (_model.banners.count == 0)
        {
            return 0.1;
        }
        else
        {
            return 10;
        }
    }
    else
        return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetListModel *model = _dataArray[indexPath.row];
    return model.totalHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tweetListID = @"tweetListID";
    TweetListCell *cell = [tableView dequeueReusableCellWithIdentifier:tweetListID];
    if (cell == nil)
    {
        cell = [[TweetListCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:tweetListID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TweetListModel *model = _dataArray[indexPath.row];
    [cell setContentWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - 属性

-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView =
        [[UITableView alloc]initWithFrame:CGRectZero
                                    style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [ColorTools tableViewBackGroundColor];
    }
    return _tableView;
}

-(BannerView *)bannerView
{
    if (_bannerView == nil)
    {
        _bannerView = [BannerView new];
        _bannerView.frame = CGRectMake(0, 0, DeviceWidth, DeviceWidth*0.21);
    }
    return _bannerView;
}

-(TweetTagListAPI *)tweetTagListAPI
{
    if (_tweetTagListAPI == nil) {
        _tweetTagListAPI = [TweetTagListAPI new];
        _tweetTagListAPI.apiMangerCallBackDelegate = self;
        _tweetTagListAPI.lasttime = 0;
    }
    return _tweetTagListAPI;
}

-(AddAttentionAPI *)addAttentionAPI
{
    if (_addAttentionAPI == nil)
    {
        _addAttentionAPI = [AddAttentionAPI new];
        _addAttentionAPI.apiMangerCallBackDelegate = self;
    }
    return _addAttentionAPI;
}

-(PraiseTweetAPI *)praiseTweetAPI
{
    if (_praiseTweetAPI == nil)
    {
        _praiseTweetAPI = [PraiseTweetAPI new];
        _praiseTweetAPI.apiMangerCallBackDelegate = self;
    }
    return _praiseTweetAPI;
}

-(OfficialBannerAPI *)officialBannerAPI
{
    if (_officialBannerAPI == nil)
    {
        _officialBannerAPI = [OfficialBannerAPI new];
        _officialBannerAPI.apiMangerCallBackDelegate = self;
    }
    return _officialBannerAPI;
}

-(CancelAttentionAPI *)cancelAttentionAPI
{
    if (_cancelAttentionAPI == nil)
    {
        _cancelAttentionAPI = [CancelAttentionAPI new];
        _cancelAttentionAPI.apiMangerCallBackDelegate = self;
    }
    return _cancelAttentionAPI;
}


@end
