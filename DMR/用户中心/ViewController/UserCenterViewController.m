//
//  UserCenterViewController.m
//  DMR
//
//  Created by shklxmac111 on 16/3/16.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import "UserCenterViewController.h"
#import "Global.h"
#import "LoginViewController.h"
#import "InteractionCell.h"
#import "TreasureCell.h"
#import "ActivityCell.h"
#import "PersonHeaderView.h"
#import "LivingLoadMoreView.h"
#import "UIResponder+Router.h"
//#import "PersonAtViewController.h"
//#import "PersonNotifyViewController.h"
//#import "PersonPraiseViewController.h"
#import "SettingViewController.h"
#import "ThemeActivitiesAPI.h"
//#import "AttentionListViewController.h"
//#import "MyCollectionViewController.h"
#import "UITableView+HeaderGif.h"
#import <MJRefresh.h>
//#import "FansListViewController.h"
//#import "AttentionListViewController.h"
#import "LoginViewController.h"
#import "PersonInfoAPI.h"
#import "PersonInfoModel.h"
#import "ThemeActivitiesModel.h"
//#import "CommentViewController.h"
#import "PersonLevelAPI.h"
#import "PersonLevelModel.h"
//#import "PersonSignViewController.h"
//#import "Banner.h"
//#import "BannerVC.h"
//#import "OthersHomePageViewController.h"
//#import "LiJumpOBJ.h"
#import "ShopViewController.h"
#import "LivingLoadMoreView.h"
//#import "PersonalInfoViewController.h"
#import "ColorTools.h"
#import "BannerPusher.h"
//#import "OthersHomePageViewController.h"
#import "PersonLeaderView.h"
#import "PersonLevelView.h"

@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,APIRequestManagerDelegate>
{
    NSInteger rowNumber;
}

// 个人主页列表
@property(nonatomic, strong) UITableView *infoTableView;
// 活动数组
@property(nonatomic, strong) NSMutableArray *activeArray;
// 头像
@property(nonatomic, strong) PersonHeaderView *headerView;
// 分区的title和图片
@property(nonatomic, strong) NSMutableArray *sectiontitleArray;
@property(nonatomic, strong) NSMutableArray *sectionImgArray;
@property(nonatomic, strong) ThemeActivitiesAPI *themeActivitiesAPI;
@property(nonatomic, strong) PersonInfoAPI *personInfoAPI;
@property(nonatomic, strong) PersonInfoModel *personInfoModel;
@property(nonatomic, strong) ThemeActivitiesModel *themeActivitiesModel;
@property(nonatomic, strong) PersonLevelAPI *personLevelAPI;
@property(nonatomic, strong) PersonLevelModel *personLevelModel;
@property(nonatomic, strong) LivingLoadMoreView *moreView;
@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, strong) UILabel *titleLable;
// 设置
@property(nonatomic, strong) UIButton *resetButton;
@property(nonatomic, strong) PersonLeaderView *leaderView;

@end

static NSString *cell1 = @"cell1";
static NSString *cell2 = @"cell2";
static NSString *cell3 = @"cell3";


@implementation UserCenterViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"quit" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"modify" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sign" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
//    MainTabBar.pushHandler.delegate = nil;
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.headerView setContentWithModel:self.personInfoModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    rowNumber = 2;
    [self initSubViews];
    [self setlayout];
    [self addNSNotification];
//    [self loadData];
//    if (MainTabBar.currentUser.uid.length > 0) {
//        NSLog(@"%@",MainTabBar.currentUser.uid);
//        [self userLogin];
//    }
    if (![UserDefault boolForKey:@"isFirstPersonEnter"]){
        [self addPersonLeaderView];
        [UserDefault setBool:YES forKey:@"isFirstPersonEnter"];
    }
}

- (void)initSubViews{
    
    self.navigationItem.titleView = self.titleLable;
    self.infoTableView.tableHeaderView = self.headerView;
//    [self.headerView setContentWithModel:self.personInfoModel];
    [self.view addSubview:self.infoTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.resetButton];
    
}

- (void)setlayout{
    
    WeakObject(weakSlef);
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.equalTo(weakSlef.view);
        make.top.equalTo(weakSlef.view).offset(0);
    }];
}

-(void)addNSNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userQuit) name:@"quit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:@"modify" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSign) name:@"sign" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:UIApplicationDidBecomeActiveNotification object:nil];
}
-(void)addPersonLeaderView{
    
//    [MainTabBar.view addSubview:self.leaderView];
}

-(void)userLogin{
    
//    [self.personInfoAPI startRequestWithUid:MainTabBar.currentUser.uid];
}

-(void)userQuit{
    
    self.personInfoModel = nil;
    [self.infoTableView reloadData];
    [self.headerView setContentWithModel:self.personInfoModel];
}

-(void)userSign{
    
//    MainTabBar.currentUser.isSign = @(1);
    [self.headerView setContentWithModel:self.personInfoModel];
    
}

-(void)loadData{
    
    self.themeActivitiesAPI.page = 1;
    [self.themeActivitiesAPI startRequestWithPageNum:self.themeActivitiesAPI.page];
}

// 上啦数据加载
-(void)loadMoreData{
    
    [self.themeActivitiesAPI startRequestWithPageNum:self.themeActivitiesAPI.page];
}

// 下拉刷新
-(void)refreshData{
    
    self.infoTableView.mj_footer.hidden = YES;
    self.themeActivitiesAPI.page = 1;
    [self.themeActivitiesAPI startRequestWithPageNum:self.themeActivitiesAPI.page];
//    if (MainTabBar.currentUser.uid.length > 0) {
//        [self userLogin];
//    } else{
//        [self userQuit];
//    }
}


#pragma mark -- 数据请求
- (void)apiRequestManagerDidSuccess:(BaseAPIManager*)apiManager{
    
    if (apiManager == _personInfoAPI) {
        
        NSDictionary *json = [_personInfoAPI fetchDataWithTransformer:nil];
        self.personInfoModel = nil;
        self.personInfoModel  = [MTLJSONAdapter modelOfClass:[PersonInfoModel class] fromJSONDictionary:json error:nil];
//        MainTabBar.currentUser.isSign = self.personInfoModel.isSign;
//        MainTabBar.currentUser.experience = self.personInfoModel.experience;
//        MainTabBar.currentUser.level = self.personInfoModel.level;
        [self.headerView setContentWithModel:self.personInfoModel];
        [self.infoTableView reloadData];
    }
    if (apiManager == _themeActivitiesAPI) {
        
        _themeActivitiesAPI.page++;
        NSDictionary *json = [_themeActivitiesAPI fetchDataWithTransformer:nil];
        self.themeActivitiesModel = [MTLJSONAdapter modelOfClass:[ThemeActivitiesModel class] fromJSONDictionary:json error:nil];
        
        if (self.themeActivitiesAPI.page == 2) {
            [self.activeArray removeAllObjects];
        }
        [self.activeArray addObjectsFromArray:self.themeActivitiesModel.data];
        if (_themeActivitiesAPI.page == 2 && _themeActivitiesModel.data.count > 2) {
            self.infoTableView.tableFooterView = self.moreView;
            [self.moreView.loadMore addTarget:self action:@selector(loadAction) forControlEvents:UIControlEventTouchUpInside];
        }
        if (self.activeArray.count > 0) {
            rowNumber = 2;
        } else{
            rowNumber = 1;
        }
        [self.infoTableView reloadData];
        [self.infoTableView.mj_footer endRefreshing];
        [self.infoTableView.mj_header endRefreshing];
        if (_themeActivitiesAPI.page > 2 && [json[@"data"] count] == 0) {
            [self.infoTableView.mj_footer noticeNoMoreData];
            self.infoTableView.mj_footer.backgroundColor = [UIColor whiteColor];
        }
    }
    
    if (apiManager == _personLevelAPI) {
        
        NSDictionary *json = [_personLevelAPI fetchDataWithTransformer:nil];
        self.personLevelModel = [MTLJSONAdapter modelOfClass:[PersonLevelModel class] fromJSONDictionary:json[@"data"] error:nil];
//        MainTabBar.currentUser.experience_to = self.personLevelModel.experience_to;
//        MainTabBar.currentUser.experience_from = self.personLevelModel.experience_from;
        [self.headerView setContentWithLevelModel:self.personLevelModel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timerAction];
        });
    }
}
- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager{
    
    if (apiManager == self.personLevelAPI) {
        [self.headerView setContentWithLevelModel:self.personLevelModel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timerAction];
        });
    }
    
    if (apiManager == self.personInfoAPI) {
        [self.headerView setContentWithModel:self.personInfoModel];
    }
    [self.infoTableView.header endRefreshing];
    [self.infoTableView.footer endRefreshing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -- tableView代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        InteractionCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (cell == nil) {
            cell = [[InteractionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        cell.indesPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setContentWithModel:self.sectiontitleArray[indexPath.section][indexPath.row] img:self.sectionImgArray[indexPath.section][indexPath.row]];
//        [cell setNotifyNumberHidden:YES number:@""];
        return cell;
        
    } else if (indexPath.section == 1){
        TreasureCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (cell == nil) {
            cell = [[TreasureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        cell.indesPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setContentWithModel:self.sectiontitleArray[indexPath.section][indexPath.row] img:self.sectionImgArray[indexPath.section][indexPath.row]];
//        if ([self cellArrowType:self.personInfoModel.notifyCount.noticeCount]) {
//            [cell setNotifyNumberHidden:NO number:[NSString stringWithFormat:@"  %@  ", self.personInfoModel.notifyCount.noticeCount]];
//        } else{
//            [cell setNotifyNumberHidden:YES number:@""];
//        }
        return cell;
        
    }
    else if (indexPath.section == 2){
        
        InteractionCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (cell == nil) {
            cell = [[InteractionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }
        cell.indesPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setContentWithModel:self.sectiontitleArray[indexPath.section][indexPath.row] img:self.sectionImgArray[indexPath.section][indexPath.row]];
        
        if (indexPath.row == 0) {
//            if ([self cellArrowType:self.personInfoModel.notifyCount.atCount]) {
//                [cell setNotifyNumberHidden:NO number:[NSString stringWithFormat:@"  %@  ", self.personInfoModel.notifyCount.atCount]];
//            } else{
//                [cell setNotifyNumberHidden:YES number:@""];
//            }
        }
        if (indexPath.row == 1) {
//            if ([self cellArrowType:self.personInfoModel.notifyCount.commentCount]) {
//                [cell setNotifyNumberHidden:NO number:[NSString stringWithFormat:@"  %@  ", self.personInfoModel.notifyCount.commentCount]];
//            } else{
//                [cell setNotifyNumberHidden:YES number:@""];
//            }
        }
        if (indexPath.row == 2) {
//            if ([self cellArrowType:self.personInfoModel.notifyCount.praiseCount]) {
//                [cell setNotifyNumberHidden:NO number:[NSString stringWithFormat:@"  %@  ", self.personInfoModel.notifyCount.praiseCount]];
//            } else{
//                [cell setNotifyNumberHidden:YES number:@""];
//            }
        }
        return cell;
        
    }else if (indexPath.section == 3){
        TreasureCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (cell == nil) {
            cell = [[TreasureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        cell.indesPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setContentWithModel:self.sectiontitleArray[indexPath.section][indexPath.row] img:self.sectionImgArray[indexPath.section][indexPath.row]];
//        [cell setNotifyNumberHidden:YES number:@""];
//        if (indexPath.row == 1) {
//            cell.arrowView.hidden = YES;
//        }
        return cell;
        
    }else if (indexPath.section == 4){
        
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cell3];
        if (cell == nil) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setContentWithModel:self.activeArray[indexPath.row]];
        cell.index = indexPath;
        return cell;
    } else{
        return nil;
    }
}

// 验证cellArrow类型
-(BOOL)cellArrowType:(NSNumber *)model{
    if (model != nil && ![model isEqual: [NSNull class]] && ![model isEqual: @"(null)"] && model.intValue > 0 && ![model isEqual: @"<null>"]) {
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
//        pleaseLogin;
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
//            [LiJumpOBJ jumptoShopDetailViewControllerWithUrl:youzanURL WithNavigationController:RootNav];
        }
    } else if (indexPath.section == 1) {
//        pleaseLogin;
        if (indexPath.row == 0) {
//            PersonNotifyViewController *notifyVC = [[PersonNotifyViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//            [MainTabBar.navigationController pushViewController:notifyVC animated:YES];
//            self.personInfoModel.notifyCount.noticeCount = @(0);
//            [self.infoTableView reloadData];
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
//            PersonAtViewController *atVC = [[PersonAtViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//            [MainTabBar.navigationController pushViewController:atVC animated:YES];
//            self.personInfoModel.notifyCount.atCount = @(0);
//            [self.infoTableView reloadData];
        }
        if (indexPath.row == 1){
//            CommentViewController *commentVC = [[CommentViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//            [MainTabBar.navigationController pushViewController:commentVC animated:YES];
//            self.personInfoModel.notifyCount.commentCount = @(0);
//            [self.infoTableView reloadData];
        }
        if (indexPath.row == 2){
//            PersonPraiseViewController *praiseVC = [[PersonPraiseViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//            [MainTabBar.navigationController pushViewController:praiseVC animated:YES];
//            self.personInfoModel.notifyCount.praiseCount = @(0);
//            [self.infoTableView reloadData];
        }
        
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
//            MyCollectionViewController *collectionVC = [[MyCollectionViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//            [MainTabBar.navigationController pushViewController:collectionVC animated:YES];
        }
        
    }else if(indexPath.section == 4) {
        
//        ActivitiesModel *model = self.activeArray[indexPath.row];
//        Banner *bannerTmp = [Banner new];
//        bannerTmp.bannerTargetType = model.type;
//        bannerTmp.bannerTarget = model.bannerTarget;
//        bannerTmp.shareUrl = model.shareUrl;
//        bannerTmp.shareTitle = model.shareTitle;
//        bannerTmp.shareContent = model.shareContent;
//        bannerTmp.sharePic = model.sharePic;
//        bannerTmp.title = model.shareTitle;
//        bannerTmp._id = model._id;
//        bannerTmp.picIp = KResoureURL;
//        [Banner pushViewWithNavigationController:MainTabBar.navigationController andBanner:bannerTmp];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
        
    } else if (section == 1){
        return 1;
        
    } else if (section == 2){
        return 3;
        
    } else if (section == 3){
        return rowNumber;
        
    }else if (section == 4){
        
        if (self.themeActivitiesAPI.page == 2) {
            if (self.infoTableView.tableFooterView != nil) {
                return 2;
            } else{
                return self.activeArray.count;
            }
        } else{
            return self.activeArray.count;
        }
    } else{
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1){
        return 60;
    }else if (indexPath.section == 2){
        return 50;
    }else if (indexPath.section == 3){
        return 60;
    } else if (indexPath.section == 4){
        return WindowSize.width * 0.4046921;
    } else{
        return 0;
    }
}

-(void)timerAction{
    [self.headerView hidenAction];
}

#pragma mark -- 事件分发处理
-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    if ([eventName isEqualToString:PersonspaceCheckTap]) {
        
//        pleaseLogin;
//        Banner *bannerTmp = [Banner new];
//        bannerTmp.bannerTargetType = @(1);
//        bannerTmp.bannerTarget = KSignUrl;
//        bannerTmp.shareTitle = @"";
//        bannerTmp.type = @"checkSign";
//        [Banner pushViewWithNavigationController:MainTabBar.navigationController andBanner:bannerTmp];
    } else if ([eventName isEqualToString:PersonspaceConcernTap]) {
        
//        pleaseLogin;
//        AttentionListViewController *attentionVC = [[AttentionListViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//        [MainTabBar.navigationController pushViewController:attentionVC animated:YES];
    } else if([eventName isEqualToString:PersonspaceDespTap]) {
        
//        pleaseLogin;
//        PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//        [MainTabBar.navigationController pushViewController:personalInfoVC animated:YES];
    } else if([eventName isEqualToString:PersonspaceFansTap]) {
        
//        pleaseLogin;
//        FansListViewController *fansListVC = [[FansListViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//        [MainTabBar.navigationController pushViewController:fansListVC animated:YES];
    } else if([eventName isEqualToString:PersonspaceHeaderTap]) {
        
//        pleaseLogin;
//        PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//        [MainTabBar.navigationController pushViewController:personalInfoVC animated:YES];
    } else if([eventName isEqualToString:PersonspaceLevelTap]) {
        
//        pleaseLogin;
//        if (MainTabBar.currentUser.level == nil || [MainTabBar.currentUser.level isKindOfClass:[NSNull class]]) {
//            self.personInfoModel.level = @(1);
//        }
//        [self.personLevelAPI startRequestWithLevel:MainTabBar.currentUser.level.intValue];
    } else if([eventName isEqualToString:PersonspaceLoginTap]) {
        
//        LoginViewController *loginVC = [LoginViewController new];
//        [MainTabBar.navigationController pushViewController:loginVC animated:YES];
    } else if([eventName isEqualToString:PersonspacePersonTap]) {
        
//        pleaseLogin;
//        OthersHomePageViewController *otherVC = [[OthersHomePageViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//        [MainTabBar.navigationController pushViewController:otherVC animated:YES];
    }else if ([eventName isEqualToString:ActivitybgTap]){
        
        NSIndexPath *indexpath = userInfo[@"indexPath"];
        [self tableView:self.infoTableView didSelectRowAtIndexPath:indexpath];
    } else if ([eventName isEqualToString:personLevelHiddenTap]){
        
        [self.headerView hidenAction];
    } else if ([eventName isEqualToString:InteractionlogoTap]){
        NSIndexPath *indexPath = userInfo[@"indexpath"];
        
//        pleaseLogin;
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                
            }
            if (indexPath.row == 1) {
//                [LiJumpOBJ jumptoShopDetailViewControllerWithUrl:youzanURL WithNavigationController:RootNav];
            }
        }
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0){
//                PersonAtViewController *atVC = [[PersonAtViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//                [MainTabBar.navigationController pushViewController:atVC animated:YES];
//                self.personInfoModel.notifyCount.atCount = @(0);
//                [self.infoTableView reloadData];
            }
            if (indexPath.row == 1){
//                CommentViewController *commentVC = [[CommentViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//                [MainTabBar.navigationController pushViewController:commentVC animated:YES];
//                self.personInfoModel.notifyCount.commentCount = @(0);
//                [self.infoTableView reloadData];
            }
            if (indexPath.row == 2){
//                PersonPraiseViewController *praiseVC = [[PersonPraiseViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//                [MainTabBar.navigationController pushViewController:praiseVC animated:YES];
//                self.personInfoModel.notifyCount.praiseCount = @(0);
//                [self.infoTableView reloadData];
            }
            
        }
        
    } else if ([eventName isEqualToString:TreasurelogoTap]){
        
        NSIndexPath *indexPath = userInfo[@"indexpath"];
//        pleaseLogin;
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
//                PersonNotifyViewController *notifyVC = [[PersonNotifyViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//                [MainTabBar.navigationController pushViewController:notifyVC animated:YES];
//                self.personInfoModel.notifyCount.noticeCount = @(0);
//                [self.infoTableView reloadData];
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                
//                MyCollectionViewController *collectionVC = [[MyCollectionViewController alloc] initWithUid:MainTabBar.currentUser.uid];
//                [MainTabBar.navigationController pushViewController:collectionVC animated:YES];
            }
        }
    }
}

-(void)loadAction{
    self.infoTableView.tableFooterView = nil;
    self.infoTableView.mj_footer.hidden = NO;
    [self.infoTableView reloadData];
}
-(void)resetAction{
//    pleaseLogin;
//    SettingViewController *setVC = [[SettingViewController alloc]initWithUid:MainTabBar.currentUser.uid];
//    [MainTabBar.navigationController pushViewController:setVC animated:YES];
}
// 属性初始化
- (UITableView *)infoTableView{
    if (_infoTableView == nil) {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.showsHorizontalScrollIndicator = NO;
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.dataSource = self;
        _infoTableView.delegate = self;
        _infoTableView.backgroundColor = [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.0];
//        [_infoTableView addGifHeaderWithRefreshingTarget:self
//                                        refreshingAction:@selector(refreshData)];
//        [_infoTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _infoTableView.mj_footer.hidden = YES;
        _infoTableView.tableFooterView = nil;
//        [_infoTableView setGifHeader:YES];
    }
    return _infoTableView;
}
-(NSMutableArray *)activeArray{
    if (_activeArray == nil) {
        _activeArray = [NSMutableArray array];
        
    }
    return _activeArray;
}
-(PersonHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[PersonHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, WindowSize.width, 157.5);
    }
    return _headerView;
}
-(NSMutableArray *)sectiontitleArray{
    if (_sectiontitleArray == nil) {
        _sectiontitleArray = [NSMutableArray arrayWithObjects:@[@"订单中心",@"我的商城"],@[@"通知"],@[@"@我的",@"评论",@"赞  "], @[@"我的收藏",@"专题活动"], nil];
    }
    return _sectiontitleArray;
}

-(NSMutableArray *)sectionImgArray{
    if (_sectionImgArray == nil) {
        _sectionImgArray = [NSMutableArray arrayWithObjects:@[@"ico_presonal_center_order",@"ico_presonal_center_shop"],@[@"ico_presonal_center_notice"],@[@"ico_presonal_center_at",@"ico_presonal_center_comment",@"ico_presonal_center_praise"],@[@"ico_presonal_center_collect", @"ico_presonal_center_special"], nil];
    }
    return _sectionImgArray;
}

-(ThemeActivitiesAPI *)themeActivitiesAPI{
    if (_themeActivitiesAPI == nil) {
        _themeActivitiesAPI = [ThemeActivitiesAPI new];
        _themeActivitiesAPI.apiMangerCallBackDelegate = self;
        _themeActivitiesAPI.page = 1;
    }
    return _themeActivitiesAPI;
}
-(PersonInfoAPI *)personInfoAPI{
    if (_personInfoAPI == nil) {
        _personInfoAPI = [PersonInfoAPI new];
        _personInfoAPI.apiMangerCallBackDelegate = self;
    }
    return _personInfoAPI;
}
-(PersonLevelAPI *)personLevelAPI{
    if (_personLevelAPI == nil) {
        _personLevelAPI =  [PersonLevelAPI new];
        _personLevelAPI.apiMangerCallBackDelegate = self;
    }
    return _personLevelAPI;
}
-(LivingLoadMoreView *)moreView{
    if (_moreView == nil) {
        _moreView = [[LivingLoadMoreView alloc] init];
        _moreView.frame = CGRectMake(0, 0, WindowSize.width, 33);
    }
    return _moreView;
}
-(UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowSize.width, 0.1)];
    }
    return _footerView;
}
-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        _titleLable.text = @"我";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
        _titleLable.textColor = [ColorTools titleColor];
    }
    return _titleLable;
}
-(UIButton *)resetButton{
    if (_resetButton == nil) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.frame = CGRectMake(0, 0, 34, 34);
        [_resetButton setImage:[UIImage imageNamed:@"btn_personal_center_set"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}
-(PersonLeaderView *)leaderView{
    if (_leaderView == nil) {
        _leaderView = [[PersonLeaderView alloc] init];
        _leaderView.frame = MainTabBar.view.bounds;
    }
    return _leaderView;
}

@end
