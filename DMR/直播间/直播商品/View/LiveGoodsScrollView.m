//
//  LiveGoodsScrollView.m
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "LiveGoodsScrollView.h"
#import "GoodsView.h"
#import "Global.h"
#import "GoodsModel.h"


#define LeftPadding  15
#define GoodsPadding 17.5  
#define GoodsWidth   50
#define GoodsHeight  50

@interface LiveGoodsScrollView ()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView   *scrollView;
@property (strong,nonatomic) NSMutableArray *products;

@end

@implementation LiveGoodsScrollView

-(void)dealloc
{
    _scrollView.delegate = nil;
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.scrollView];
        [self setLayouts];
    }
    return self;
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 属性

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)setContentWithProducts:(NSMutableArray *)products
{
    if (_products == nil)
    {
        _products = [NSMutableArray new];
        [_products addObjectsFromArray:products];
    }
    else
    {
        [_products removeAllObjects];
        [_products addObjectsFromArray:products];
    }
    for (GoodsModel *model in _products)
    {
        NSInteger index = [_products indexOfObject:model];
        GoodsView *view = [[GoodsView alloc]init];
        [view setContentWithModel:model];
        view.frame = CGRectMake(LeftPadding + index*(GoodsPadding + GoodsWidth),
                                0,
                                GoodsWidth,
                                GoodsHeight);
        [_scrollView addSubview:view];
    }
    _scrollView.contentSize = CGSizeMake((GoodsWidth+GoodsPadding)*_products.count,GoodsWidth);
}

@end
