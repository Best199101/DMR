//
//  LiveGoodsViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "LiveGoodsViewController.h"
#import "LiveGoodsScrollView.h"
#import "UIResponder+Router.h"
#import "Global.h"

#define GoodsScrollViewHeight     50
#define GoodsScrollViewTopPadding 50

@interface LiveGoodsViewController ()

@property (strong,nonatomic) LiveGoodsScrollView *liveGoodsScrollView;
@property (strong,nonatomic) NSMutableArray *products;

@end

@implementation LiveGoodsViewController

-(instancetype)initWithProducts:(NSMutableArray *)products
{
    if (self = [super init]) {
        _products = [NSMutableArray new];
        [_products addObjectsFromArray:products];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.liveGoodsScrollView];
    [self setLayouts];
    [_liveGoodsScrollView setContentWithProducts:_products];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_liveGoodsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(GoodsScrollViewHeight));
        make.top.equalTo(weakSelf.view.mas_top).with.offset(GoodsScrollViewTopPadding);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 属性

-(LiveGoodsScrollView *)liveGoodsScrollView
{
    if (_liveGoodsScrollView == nil)
    {
        _liveGoodsScrollView = [LiveGoodsScrollView new];
    }
    return _liveGoodsScrollView;
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
