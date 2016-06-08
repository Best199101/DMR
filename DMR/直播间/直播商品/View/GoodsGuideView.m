//
//  GoodsGuideView.m
//  happigo
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "GoodsGuideView.h"
#import "GoodsView.h"
#import "ColorTools.h"
#import "UIResponder+Router.h"
#import "GoodsModel.h"
#import "Global.h"

#define BaseHeight          340
#define GoodsViewXPadding   50
#define TitleXPadding       22.5

NSString *const LiveGoodsDetailButtonTapped        = @"LiveGoodsDetailButtonTapped";
NSString *const LiveGoodsCollectButtonTapped       = @"LiveGoodsCollectButtonTapped";
NSString *const LiveGoodsCancelCollectButtonTapped = @"LiveGoodsCancelCollectButtonTapped";

@interface GoodsGuideView ()

@property (strong,nonatomic) GoodsView *goodsView;
@property (strong,nonatomic) UILabel *logoLabel;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *originPriceLabel;
@property (strong,nonatomic) UILabel *presentPriceLabel;
@property (strong,nonatomic) UIButton *detailButton;
@property (strong,nonatomic) UIButton *collectButton;

@end

@implementation GoodsGuideView

-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self initSubViews];
        [self setLayouts];
        self.backgroundColor = [UIColor whiteColor];
        [self setCornerRadius:10];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.logoLabel];
    [self addSubview:self.goodsView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.originPriceLabel];
    [self addSubview:self.presentPriceLabel];
    [self addSubview:self.detailButton];
    [self addSubview:self.collectButton];
    
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(40);
        make.height.equalTo(@190);
        make.width.equalTo(@190);
        make.centerX.equalTo(weakSelf);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(22.5);
        make.right.equalTo(weakSelf.mas_right).with.offset(-22.5);
        make.top.equalTo(_goodsView.mas_bottom).with.offset(6);
        make.bottom.equalTo(_originPriceLabel.mas_top).with.offset(-6);
    }];

    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(22.5);
        make.width.equalTo(@114);
        make.height.equalTo(@28);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-17.5);
    }];
    [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-22.5);
        make.width.equalTo(@114);
        make.height.equalTo(@28);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-17.5);
    }];
    [_originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(22.5);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
        make.bottom.equalTo(_detailButton.mas_top).with.offset(-12);
    }];
    [_presentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-22.5);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
        make.bottom.equalTo(_collectButton.mas_top).with.offset(-12);
    }];
}

#pragma mark - 公有

+(CGFloat)heightForModel:(GoodsModel *)model
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:.1];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize size = [model.pTitle
                   boundingRectWithSize:CGSizeMake(290 - 45, 50)
                   options:NSStringDrawingUsesFontLeading|
                   NSStringDrawingUsesLineFragmentOrigin|
                   NSStringDrawingTruncatesLastVisibleLine
                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSParagraphStyleAttributeName:paragraphStyle}
                   context:nil].size;
    model.titleHeight = size.height;
    return size.height + BaseHeight;
}

-(void)setContentWithModel:(GoodsModel *)model
{
    _model = model;
    [_goodsView setContentWithModel:model];
    _nameLabel.text = model.pTitle;
    [self setOriginPrice:model];
    [self setPresentPrice:model];
}

#pragma mark - 配置

-(void)setOriginPrice:(GoodsModel *)model
{
    NSMutableAttributedString *temp =
    [[NSMutableAttributedString alloc]initWithString:
     [NSString stringWithFormat:@"官方参考价:  %@",model.oPrice]];
    [temp addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                          NSForegroundColorAttributeName:[ColorTools officialPriceTextColor]}
                  range:NSMakeRange(0, temp.length)];
    [_originPriceLabel setAttributedText:temp];
}

-(void)setPresentPrice:(GoodsModel *)model
{
    NSMutableAttributedString *temp =
    [[NSMutableAttributedString alloc]initWithString:
     [NSString stringWithFormat:@"￥ %@",model.oPrice]];
    NSRange symbolRange = [temp.string rangeOfString:@"￥"];
    NSRange priceRange  = [temp.string rangeOfString:model.oPrice];
    [temp addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                          NSForegroundColorAttributeName:[ColorTools textColor]}
                  range:symbolRange];
    [temp addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],
                          NSForegroundColorAttributeName:[ColorTools themePinkColor]}
                  range:priceRange];
    [_presentPriceLabel setAttributedText:temp];
    
}

-(void)setCollectButtonState:(BOOL)collected
{
    if (!collected)
    {
        [_collectButton setTitle:@"加入收藏" forState:UIControlStateNormal];
        [_collectButton addTarget:self
                           action:@selector(collect)
                 forControlEvents:UIControlEventTouchUpInside];

    }
    else
    {
        [_collectButton setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_collectButton addTarget:self
                           action:@selector(cancelCollect)
                 forControlEvents:UIControlEventTouchUpInside];

    }
}

#pragma mark - 点击

-(void)detail
{
    [self routerEventWithName:LiveGoodsDetailButtonTapped
                     userInfo:@{}];
}

-(void)collect
{
    [self routerEventWithName:LiveGoodsCollectButtonTapped
                     userInfo:@{}];
}

-(void)cancelCollect
{
    [self routerEventWithName:LiveGoodsCancelCollectButtonTapped
                     userInfo:@{}];
}

#pragma mark - 属性

-(UILabel *)logoLabel
{
    if (_logoLabel == nil)
    {
        _logoLabel = [UILabel new];
        _logoLabel.font = [UIFont systemFontOfSize:15];
        _logoLabel.textColor = [UIColor whiteColor];
        _logoLabel.numberOfLines = 0;
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        _logoLabel.backgroundColor = [UIColor colorWithRed:248/255.0
                                                     green:131/255.0
                                                      blue:65/255.0
                                                     alpha:1];
        _logoLabel.text = @"直播美抢go";
    }
    return _logoLabel;
}


-(GoodsView *)goodsView
{
    if (_goodsView == nil)
    {
        _goodsView = [GoodsView new];
    }
    return _goodsView;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [ColorTools goodsNameTextColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.backgroundColor = [UIColor redColor];
    }
    return _nameLabel;
}

-(UILabel *)originPriceLabel
{
    if (_originPriceLabel == nil)
    {
        _originPriceLabel = [UILabel new];
        _originPriceLabel.font = [UIFont systemFontOfSize:13];
        _originPriceLabel.textColor = [ColorTools officialPriceTextColor];
        _originPriceLabel.textAlignment = NSTextAlignmentLeft;
        _originPriceLabel.backgroundColor = [UIColor greenColor];

    }
    return _originPriceLabel;
}

-(UILabel *)presentPriceLabel
{
    if (_presentPriceLabel == nil)
    {
        _presentPriceLabel = [UILabel new];
        _presentPriceLabel.textAlignment = NSTextAlignmentLeft;
        _presentPriceLabel.backgroundColor = [UIColor yellowColor];

    }
    return _presentPriceLabel;
}

-(UIButton *)detailButton
{
    if (_detailButton == nil)
    {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton addTarget:self
                          action:@selector(detail)
                forControlEvents:UIControlEventTouchUpInside];
        [_detailButton setCornerRadius:14];
        _detailButton.backgroundColor = [ColorTools officialPriceTextColor];
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailButton;
}

-(UIButton *)collectButton
{
    if (_collectButton == nil)
    {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setCornerRadius:14];
        _collectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _collectButton.backgroundColor = [ColorTools themePinkColor];
    }
    return _collectButton;
}



@end
