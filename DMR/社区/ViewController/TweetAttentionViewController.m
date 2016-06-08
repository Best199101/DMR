//
//  TweetAttentionViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/14.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetAttentionViewController.h"
#import "TweetAttentionListAPI.h"
#import "ColorTools.h"
#import "AttentionModel.h"
#import "TweetListModel.h"
#import "TweetAttentionCell.h"
#import "TweetListCell.h"
#import "AttentionHeaderView.h"
#import "MJRefresh.h"
#import "Global.h"

@interface TweetAttentionViewController ()
<APIRequestManagerDelegate,
UITableViewDelegate,
UITableViewDataSource>

{
    long lastTime;//上一次更新时间
    BOOL hasConcern;//当hasConcern=1时，代表有关注人，返回的数据结构中的list同精选帖子列表，当hasConcern=0时，代表没有关注人，返回的数据结构中的list内容同推荐@的人
}

@property (strong, nonatomic) TweetAttentionListAPI *tweetAttentionListAPI;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AttentionHeaderView *attentionHeaderView;
@end

@implementation TweetAttentionViewController

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
    lastTime = 0;
    [self.view addSubview:self.tableView];
    
    
    NSMutableArray *arr1 = [NSMutableArray new];
//    for (int i = 1 ; i < 9 ; i++) {
//        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"load_common_type1_%d",i]];
//        [arr1 addObject:img];
//    }

    //tableView添加下拉和上拉刷新
//    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)] ;
//    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
//    
//    [self.tableView.gifHeader setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshHeaderStateIdle];
//    [self.tableView.gifHeader setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshHeaderStatePulling];
//    [self.tableView.gifHeader setImages:arr1 forState:MJRefreshHeaderStateRefreshing];
    
    WeakObject(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    [self.tweetAttentionListAPI startRequestWithLastTime:lastTime uid:@"000f48b6-76dd-437c-bee4-a60520728632"];
    //[self.tweetAttentionListAPI startRequestWithLastTime:0 uid:MainTabBar.currentUser.uid];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件

-(void)loadMore{
    [self.tweetAttentionListAPI startRequestWithLastTime:lastTime uid:@"000f48b6-76dd-437c-bee4-a60520728632"];
}

-(void)refreshTableView{
    lastTime = 0;
    [_dataArray removeAllObjects];
    [self.tweetAttentionListAPI startRequestWithLastTime:lastTime uid:@"000f48b6-76dd-437c-bee4-a60520728632"];
}

#pragma mark - 私有代理

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager{
    
}

-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager{
    NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
    NSNumber *test = [json objectForKey:@"lastTime"];
    lastTime = test.longValue;
    NSDictionary *data = [json objectForKey:@"data"];
    hasConcern = [[data objectForKey:@"hasConcern"] intValue];
    NSArray *jsonArray = [data objectForKey:@"list"];
    if (!jsonArray.count) {
        [self.tableView.footer noticeNoMoreData];
        return;
    }
    
    NSArray *modelArray = [MTLJSONAdapter modelsOfClass:hasConcern ? [TweetListModel class] : [AttentionModel class]
                                          fromJSONArray:jsonArray
                                                  error:nil];
    if (!hasConcern) {
        self.tableView.tableHeaderView = self.attentionHeaderView;
    }
    [_dataArray addObjectsFromArray:modelArray];
//    [self.tableView.header endRefreshing];
//    [self.tableView.footer endRefreshing];
    [_tableView reloadData];
}

#pragma mark - tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return hasConcern ? 0.1 : 210;
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
    return hasConcern ? ((TweetListModel *)_dataArray[indexPath.row]).totalHeight : 66;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (hasConcern) {
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
    }else{
        static NSString *cellID = @"cellID";
        TweetAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == cell) {
            cell = [[TweetAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setContentWithModel:_dataArray[indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma mark - 属性

-(UITableView *)tableView{
    if (nil == _tableView) {
        _tableView =
        [[UITableView alloc] initWithFrame:CGRectZero
                                     style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [ColorTools tableViewBackGroundColor];
    }
    return _tableView;
}

-(TweetAttentionListAPI *)tweetAttentionListAPI{
    if (nil == _tweetAttentionListAPI) {
        _tweetAttentionListAPI = [TweetAttentionListAPI new];
        _tweetAttentionListAPI.apiMangerCallBackDelegate = self;
    }
    return _tweetAttentionListAPI;
}

-(AttentionHeaderView *)attentionHeaderView{
    if (nil == _attentionHeaderView) {
        _attentionHeaderView = [[AttentionHeaderView alloc] init];
    }
    return _attentionHeaderView;
}
@end
