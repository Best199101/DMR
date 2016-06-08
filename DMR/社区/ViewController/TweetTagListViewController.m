//
//  TweetTagListViewController.m
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/4.
//  Created by 李海龙 on 16/1/1.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TweetTagListViewController.h"
#import "TweetTagListAPI.h"
#import "ColorTools.h"
#import "TweetListModel.h"
#import "TweetListCell.h"
#import "MJRefresh.h"
#import "UIResponder+Router.h"
#import "TagView.h"
#import "AddAttentionAPI.h"
#import "CancelAttentionAPI.h"
#import "ConcernAndBlackListModel.h"
#import "AppDelegate.h"
#import "PraiseTweetAPI.h"
#import "BannerView.h"
#import "TrailBannerAPI.h"
#import "OfficialAnnouncementModel.h"
#import "TweetDetailViewController.h"
#import "ShareDetailViewController.h"
#import "BannerModel.h"
#import "BannerPusher.h"
#import "Global.h"

@interface TweetTagListViewController ()
<APIRequestManagerDelegate,
UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TweetTagListAPI *tweetTagListAPI;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) long lastTime;
@property (nonatomic, strong) AddAttentionAPI *addAttentionAPI;
@property (nonatomic, strong) CancelAttentionAPI *cancelAttentionAPI;
@property (nonatomic, strong) PraiseTweetAPI *praiseTweetAPI;
@property (nonatomic, strong) BannerView *bannerView;
@property (nonatomic, strong) TrailBannerAPI *trailBannerAPI;
@property (nonatomic, strong) OfficialAnnouncementModel *model;

@end

@implementation TweetTagListViewController

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

-(instancetype)initWithTag:(NSString *)tag
{
    if (self = [super init])
    {
        _tag = tag;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 定义Nav
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_top_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(onBack)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:255/255.0 green:117/255.0 blue:159/255.0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem =item;
    
    self.title = _tag;
    [self initSubViews];
    [self setLayouts];
    [self startRequestData];
    if ([_tag isEqualToString:@"试用活动"])
    {
        [self.trailBannerAPI startRequest];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - 私有方法

-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)startRequestData{
    [self.tweetTagListAPI startRequestWithTagname:self.tag Lasttime:self.lastTime];
}

-(void)initSubViews{
    self.lastTime = 0;
    [self.view addSubview:self.tableView];
}

-(void)setLayouts{
    WeakObject(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}

#pragma mark 下拉刷新和上拉加载

-(void)loadMore{
    [self startRequestData];
}

-(void)refreshTableView{
    self.lastTime = 0;
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self startRequestData];
}
#pragma mark - 公有方法


#pragma mark - 私有代理

- (void)apiRequestManagerDidSuccess:(BaseAPIManager*)apiManager
{
}

- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{

    
}

#pragma mark - 事件分发处理

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height4Row = ((TweetListModel*)self.dataArray[indexPath.row]).totalHeight;
    
    return height4Row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        if (_model.banners.count == 0) {
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.dataArray.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = 1;
    return sections;
}


#pragma mark - 属性

-(PraiseTweetAPI *)praiseTweetAPI
{
    if (nil == _praiseTweetAPI) {
        _praiseTweetAPI = [PraiseTweetAPI new];
        _praiseTweetAPI.apiMangerCallBackDelegate = self;
    }
    return _praiseTweetAPI;
}

-(CancelAttentionAPI *)cancelAttentionAPI
{
    if (nil == _cancelAttentionAPI) {
        _cancelAttentionAPI = [CancelAttentionAPI new];
        _cancelAttentionAPI.apiMangerCallBackDelegate = self;
    }
    return _cancelAttentionAPI;
}

-(AddAttentionAPI *)addAttentionAPI
{
    if (nil == _addAttentionAPI) {
        _addAttentionAPI = [AddAttentionAPI new];
        _addAttentionAPI.apiMangerCallBackDelegate = self;
    }
    return _addAttentionAPI;
}

-(UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate =self;
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


-(TweetTagListAPI *)tweetTagListAPI{
    if (nil == _tweetTagListAPI) {
        _tweetTagListAPI = [[TweetTagListAPI alloc] init];
        _tweetTagListAPI.apiMangerCallBackDelegate = self;
    }
    return _tweetTagListAPI;
}

-(TrailBannerAPI *)trailBannerAPI
{
    if (nil == _trailBannerAPI)
    {
        _trailBannerAPI = [TrailBannerAPI new];
        _trailBannerAPI.apiMangerCallBackDelegate = self;
    }
    return _trailBannerAPI;
}

-(NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
