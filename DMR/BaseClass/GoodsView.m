//
//  GoodsView.m
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "GoodsView.h"
#import "GoodsModel.h"
#import "Global.h"
#import "UIResponder+Router.h"

NSString *const LiveGoodsTapped  = @"LiveGoodsTapped";

@interface GoodsView ()

@property (strong, nonatomic) UIButton *goodsButton;
@property (strong, nonatomic) UIImageView *tagView;

@end

@implementation GoodsView

-(instancetype)init
{
    if (self = [super init])
    {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.goodsButton];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_goodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 外部调用

-(void)setContentWithModel:(GoodsModel *)model
{
    _model = model;
    [_goodsButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.pUrl]
                                      forState:UIControlStateNormal
                              placeholderImage:[UIImage imageNamed:@"back"]];
}

#pragma mark - 点击商品

-(void)selectGoods
{
    [self routerEventWithName:LiveGoodsTapped
                     userInfo:@{@"model":_model}];
}

-(UIButton *)goodsButton
{
    if (_goodsButton == nil)
    {
        _goodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodsButton addTarget:self
                         action:@selector(selectGoods)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsButton;
}


@end
