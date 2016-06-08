//
//  TweetChoiceViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/14.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetChoiceViewController.h"
#import "TweetListChoiceAPI.h"
#import "TweetListModel.h"
#import "TweetListCell.h"
#import "TweetNoticeCell.h"
#import "ColorTools.h"
#import "UIResponder+Router.h"
#import "PortraitView.h"
#import "CommonBannerAPI.h"
#import "CommonBannerModel.h"
#import "BannerView.h"
#import "UIResponder+Router.h"
#import "OfficialTweetListViewController.h"
#import <MJRefresh.h>
#import "PraiseTweetAPI.h"
#import "AddAttentionAPI.h"
#import "CommonBannerView.h"
#import "TagView.h"
#import "TweetTagListViewController.h"
#import "TweetDetailViewController.h"
#import "OfficialTweetListViewController.h"
#import "ShareDetailViewController.h"
#import "AppDelegate.h"
#import "ConcernAndBlackListModel.h"
#import "CancelAttentionAPI.h"
#import "ActiveListViewController.h"
#import "BannerPusher.h"
#import "BannerModel.h"
#import "Global.h"

@interface TweetChoiceViewController ()
<APIRequestManagerDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (strong,nonatomic) TweetListChoiceAPI *tweetListChoiceAPI;
@property (strong,nonatomic) CommonBannerAPI *commonBannerAPI;
@property (strong,nonatomic) AddAttentionAPI *addAttentionAPI;
@property (strong,nonatomic) CancelAttentionAPI *cancelAttentionAPI;
@property (strong,nonatomic) PraiseTweetAPI *praiseTweetAPI;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) CommonBannerView *commonBannerView;
@property (strong,nonatomic) CommonBannerModel *commonBannerModel;

@end

@implementation TweetChoiceViewController

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    [self.view addSubview:self.tableView];
    WeakObject(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).with.offset(-50);
    }];
    [_tableView.header beginRefreshing];
}

#pragma mark - 列表刷新

-(void)loadMoreData
{
}

-(void)refreshData
{
    NSLog(@"%s",__func__);
    _tweetListChoiceAPI.lastTime = @0;
    [self.commonBannerAPI startRequest];
}

#pragma mark - 私有代理

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
    if (apiManager == _commonBannerAPI)
    {
        NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
        _commonBannerModel = [MTLJSONAdapter modelOfClass:[CommonBannerModel class]
                                       fromJSONDictionary:json
                                                    error:nil];
        if (_commonBannerModel.banners.count > 0
            || _commonBannerModel.banner_left.length  > 0
            || _commonBannerModel.banner_right.length > 0) {
            [self.commonBannerView setContentWithModel:_commonBannerModel];
            _tableView.tableHeaderView = _commonBannerView;
            [_tableView reloadData];
        }
        else
        {
            _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.1)];
            [_tableView reloadData];
        }
    }
    else if (apiManager == _tweetListChoiceAPI)
    {
        NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
        TweetList *list = [MTLJSONAdapter modelOfClass:[TweetList class]
                                    fromJSONDictionary:json
                                                 error:nil];
        if (_tweetListChoiceAPI.lastTime.longLongValue == 0)
        {
            [_dataArray removeAllObjects];
        }
        for (TweetListModel *model in list.data) {
            NSArray *array = [ApplicationDelegate.synchronizeManager
                              findIssuesInTable:BlackList
                              Match:model.uid];
            if (array.count == 0)
            {
                [_dataArray addObject:model];
            }
        }
        _tweetListChoiceAPI.lastTime = list.lastTime;
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        if (list.data.count < 20)
        {
            [_tableView.footer noticeNoMoreData];
        }
    }
    else if (apiManager == _praiseTweetAPI)
    {
        NSInteger temp = _praiseTweetAPI.model.praiseCount.integerValue + 1;
        _praiseTweetAPI.model.praiseCount = [NSNumber numberWithInteger:temp];
        _praiseTweetAPI.model.isPraise = @1;
        [_tableView reloadData];
    }
    else if (apiManager == _addAttentionAPI)
    {
        ConcernAndBlackModel *model = [ConcernAndBlackModel new];
        model.headurl = _addAttentionAPI.model.headurl;
        model.nickname = _addAttentionAPI.model.nickname;
        model.level = _addAttentionAPI.model.level;
        model.uid = _addAttentionAPI.model.uid;
//        model.currentuid = MainTabBar.currentUser.uid;
        model.ismaster = _addAttentionAPI.model.ismaster;
        [ApplicationDelegate.synchronizeManager addIssueInTable:ConcernList Model:model];
        for (TweetListModel *listmodel in _dataArray)
        {
            if ([listmodel.uid isEqualToString:_addAttentionAPI.model.uid])
            {
                listmodel.attentionActionState = 0;
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:ConcernStateChanged
                                                           object:nil
                                                         userInfo:@{@"uid":_addAttentionAPI.model.uid}];
        
        
    }
    else if (apiManager == _cancelAttentionAPI)
    {
        [ApplicationDelegate.synchronizeManager
         deleteIssueInTable:ConcernList
         Match:_cancelAttentionAPI.model.uid];
        for (TweetListModel *listmodel in _dataArray)
        {
            if ([listmodel.uid isEqualToString:_cancelAttentionAPI.model.uid])
            {
                listmodel.attentionActionState = 0;
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:ConcernStateChanged
                                                           object:nil
                                                         userInfo:@{@"uid":_cancelAttentionAPI.model.uid}];
        
    }
}

#pragma mark - 事件分发处理

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
}

#pragma mark - 列表代理

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (_commonBannerModel.banners.count > 0
            || _commonBannerModel.banner_left.length > 0
            || _commonBannerModel.banner_right.length > 0)
        {
            return 10;
        }
        else
        {
            return 0;
        }
    }
    else if (section == 1)
    {
        if (_commonBannerModel.broadcast.length > 0)
        {
            return 10;
        }
        else
        {
            return 0.1;
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
    if (section == 0)
        return 1;
    else if (section == 1)
        return _dataArray.count;
    else
        return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (_commonBannerModel.broadcast.length > 0)
        {
            return 62.5;
        }
        else
        {
            return 0.1;
        }
    }
    else if (indexPath.section == 1)
    {
        TweetListModel *model = _dataArray[indexPath.row];
        return model.totalHeight;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *tweetNoticeID = @"tweetNoticeID";
        TweetNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetNoticeID"];
        if (cell == nil)
        {
            cell = [[TweetNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:tweetNoticeID];
            cell.arrowImageView.image = [UIImage imageNamed:@"ico_shequ_latest_events_info"];
            cell.iconImageView.image = [UIImage imageNamed:@"ico_shequ_latest_events"];
            cell.clipsToBounds = YES;
        }
        cell.contentLabel.text = _commonBannerModel.broadcast;
        
        return cell;
    }
    else if (indexPath.section == 1)
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
    else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 1)];
        _tableView.backgroundColor = [ColorTools tableViewBackGroundColor];
        
        _tableView.scrollsToTop = YES;
    }
    return _tableView;
}

-(CommonBannerView *)commonBannerView
{
    if (_commonBannerView == nil)
    {
        _commonBannerView = [CommonBannerView new];
        _commonBannerView.frame = CGRectMake(0, 0, DeviceWidth, [CommonBannerView heightForCommonBannerView]);
    }
    return _commonBannerView;
}

-(TweetListChoiceAPI *)tweetListChoiceAPI
{
    if (_tweetListChoiceAPI == nil)
    {
        _tweetListChoiceAPI = [TweetListChoiceAPI new];
        _tweetListChoiceAPI.lastTime = @0;
        _tweetListChoiceAPI.apiMangerCallBackDelegate = self;
    }
    return _tweetListChoiceAPI;
}

-(CommonBannerAPI *)commonBannerAPI
{
    if (_commonBannerAPI == nil)
    {
        _commonBannerAPI = [CommonBannerAPI new];
        _commonBannerAPI.channelCode = @"0";
        _commonBannerAPI.apiMangerCallBackDelegate = self;
    }
    return _commonBannerAPI;
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

-(CancelAttentionAPI *)cancelAttentionAPI
{
    if (_cancelAttentionAPI == nil)
    {
        _cancelAttentionAPI = [CancelAttentionAPI new];
        _cancelAttentionAPI.apiMangerCallBackDelegate = self;
    }
    return _cancelAttentionAPI;
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


@end
