//
//  TweetViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "TweetViewController.h"
#import "CAPSPageMenu.h"
#import "TweetNewViewController.h"
#import "TweetChoiceViewController.h"
#import "TweetAttentionViewController.h"
#import "ColorTools.h"
#import "UIColor+HEX.h"
#import "BannerView.h"
#import "Global.h"
@interface TweetViewController ()
<CAPSPageMenuDelegate>

@property (strong,nonatomic) CAPSPageMenu *pageMenu;
@property (strong,nonatomic) UISegmentedControl *titleSegmentControl;


@end

@implementation TweetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleSegmentControl;
    [self initSubViewControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法

-(void)initSubViewControllers
{
    TweetNewViewController      *newController        = [TweetNewViewController new];
    TweetChoiceViewController   *choiceController     = [TweetChoiceViewController new];
    TweetAttentionViewController *attentionController = [TweetAttentionViewController new];
    choiceController.title    = @"精选";
    newController.title       = @"最新";
    attentionController.title = @"关注";
    NSArray *controllerArray = @[attentionController,choiceController,newController];
    NSDictionary *parameters =
    @{
      CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
        CAPSPageMenuOptionSelectionIndicatorColor:[UIColor whiteColor],
        CAPSPageMenuOptionBottomMenuHairlineColor:[UIColor colorWithHex:0xeeebeb],
                   CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:15.0f],
                     CAPSPageMenuOptionMenuHeight:@(0),
                CAPSPageMenuOptionCenterMenuItems:@(YES),
                     CAPSPageMenuOptionMenuMargin:@(0),
                  CAPSPageMenuOptionMenuItemWidth:@(DeviceWidth/3),
     CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor whiteColor],
   CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor whiteColor],
    };
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray
                                                        frame:CGRectMake(0,0,DeviceWidth,DeviceHeight)
                                                      options:parameters];
    _pageMenu.delegate = self;
    [self.view addSubview:_pageMenu.view];
    MenuItemView *menuFirst = self.pageMenu.menuItems.firstObject;
    menuFirst.titleLabel.font = [UIFont systemFontOfSize:16.0f];
}

#pragma mark - 私有代理

-(void)didMoveToPage:(UIViewController *)controller
               index:(NSInteger)index
{
    NSLog(@"%s",__func__);
    _titleSegmentControl.selectedSegmentIndex = index;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    NSLog(@"%s",__func__);
    if ([keyPath isEqualToString:@"selectedSegmentIndex"])
    {
        NSDictionary *dic = [[NSMutableDictionary alloc] init];
        NSInteger new = [change[@"new"]integerValue];
        NSInteger old = [change[@"old"]integerValue];
        [_pageMenu moveToPage:new];
    }
}

#pragma mark - 属性

-(UISegmentedControl *)titleSegmentControl
{
    if (_titleSegmentControl == nil)
    {
        _titleSegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"精选",@"最新",@"关注"]];
        _titleSegmentControl.selectedSegmentIndex = 0;
        [_titleSegmentControl addObserver:self
                               forKeyPath:@"selectedSegmentIndex"
                                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                  context:nil];
        [_titleSegmentControl setWidth:60 forSegmentAtIndex:0];
        [_titleSegmentControl setWidth:60 forSegmentAtIndex:1];
        [_titleSegmentControl setWidth:60 forSegmentAtIndex:2];
        _titleSegmentControl.tintColor = [ColorTools themePinkColor];
    }
    return _titleSegmentControl;
}

@end
