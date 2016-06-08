//
//  LiveGoodsGuideViewController.m
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "LiveGoodsGuideViewController.h"
#import "Global.h"
#import "UIResponder+Router.h"
#import "GoodsGuideView.h"
#import "FXBlurView.h"

@interface LiveGoodsGuideViewController ()

@property (strong,nonatomic) GoodsGuideView *goodsGuideView;
@property (strong,nonatomic) GoodsModel *model;

@end

@implementation LiveGoodsGuideViewController

-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}


-(void)loadView
{
    [super loadView];
    FXBlurView *view = [[FXBlurView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [view setBlurEnabled:NO];
    [view setBlurRadius:1];
    self.view = view;
}

-(instancetype)initWithModel:(GoodsModel *)model
{
    if (self = [super init])
    {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat height = [GoodsGuideView heightForModel:_model];
    [self.view addSubview:self.goodsGuideView];
    [_goodsGuideView setContentWithModel:_model];
    WeakObject(weakSelf);
    [_goodsGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.width.equalTo(@290);
        make.height.equalTo(@(height));
    }];
}

-(void)addTapAction:(SEL)selector Target:(id)target
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:selector];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 上层事件分发

-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:LiveGoodsDetailButtonTapped])
    {
        
    }
    else if ([eventName isEqualToString:LiveGoodsCollectButtonTapped])
    {
        
    }
}

#pragma mark - 属性

-(GoodsGuideView *)goodsGuideView
{
    if (_goodsGuideView == nil)
    {
        _goodsGuideView = [GoodsGuideView new];
    }
    return _goodsGuideView;
}

@end
