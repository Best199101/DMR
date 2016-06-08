//
//  TweetNewViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/14.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetNewViewController.h"
#import <MJRefresh.h>
#import "TweetListChoiceAPI.h"
#import "TweetListModel.h"
#import "TweetListCell.h"
#import "UIResponder+Router.h"
#import "BannerView.h"
//#import "BannerModel.h"
#import "TweetNoticeCell.h"
#import "Global.h"
@interface TweetNewViewController ()
<UITableViewDataSource,UITableViewDelegate,APIRequestManagerDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation TweetNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray new];
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件分发处理

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    
}

#pragma mark - 列表代理

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
        return 50;
    }
    else if (indexPath.section == 1)
    {
        //        TweetListModel *model = _dataArray[indexPath.row];
        //        return model.contentHeight + model.imagesHeight + model.commentHeight;
        return 50;
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
            cell.contentLabel.text = @"我是官方通告,最新活动看这里";
            cell.arrowImageView.image = [UIImage imageNamed:@""];
        }
        return cell;
    }
    else if (indexPath.section == 1)
    {
        static NSString *tweetListID = @"tweetListID";
        TweetListCell *cell = [tableView dequeueReusableCellWithIdentifier:tweetListID];
        TweetListModel *model = _dataArray[indexPath.row];
        if (cell == nil)
        {
            cell = [[TweetListCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:tweetListID];
        }
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
    if (indexPath.section == 0)
    {
        
    }
    else if (indexPath.section == 1)
    {
        TweetListModel *model = _dataArray[indexPath.row];
    }
}


-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView =
        [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)
                                    style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 1)];
    }
    return _tableView;
}



@end
