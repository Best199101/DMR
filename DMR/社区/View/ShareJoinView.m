//
//  ShareJoinView.m
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "ShareJoinView.h"
#import "PortraitView.h"
#import "ColorTools.h"
#import "UIResponder+Router.h"
#import "PraiseUserModel.h"
#import "Global.h"

#define kEdgeDistance 7.5
#define kImageSize 35
#define kJoinWidth 75
#define kViewHeight 50
#define kLeftEdge 10

@interface ShareJoinView ()

@property (strong,nonatomic) UIView *view;
@property (strong,nonatomic) UILabel *upLine;
@property (strong,nonatomic) UILabel *downLine;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIButton *joinButton;
@property (strong,nonatomic) NSMutableArray *portraitViewArray;

@end
@implementation ShareJoinView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
        [self setLayouts];
        [self portraitViewArray];
    }
    return self;
}

#pragma mark - 初始化

- (void)initSubviews {
    [self addSubview:self.view];
    [self addSubview:self.upLine];
    [self addSubview:self.downLine];
    [self addSubview:self.scrollView];
    [self addSubview:self.joinButton];
}

- (void)setLayouts {
    WeakObject(weakSelf);
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.width.equalTo(weakSelf.mas_width);
        make.height.equalTo(weakSelf.mas_height);
    }];
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.mas_equalTo(@.5);
    }];
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.mas_equalTo(@.5);
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upLine.mas_bottom).with.offset(0);
        make.bottom.equalTo(_view.mas_bottom).with.offset(0);
        make.left.equalTo(_view.mas_left).with.offset(0);
        make.right.equalTo(_view.mas_right).with.offset(-kJoinWidth);
    }];
    [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upLine.mas_bottom).with.offset(0);
        make.bottom.equalTo(_downLine.mas_top).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.width.mas_equalTo(@(kJoinWidth));
    }];
}

#pragma mark - 配置内容

- (void)setContentWithArray:(NSArray *)array withNumberOfJoinPeople:(NSString *)number{
    [_joinButton setTitle:[NSString stringWithFormat:@"%@人\n参与",number] forState:UIControlStateNormal];
    for (UIView *view in _portraitViewArray)
    {
        view.hidden = YES;
    }
    if (!array.count)
    {
        return;
    }
    for (NSInteger i = 0; i < array.count; i++) {
        PraiseUserModel *model = array[i];
        PortraitView *portraitView = _portraitViewArray[i];
        portraitView.hidden = NO;
        [portraitView setContentWithUserInfo:@{@"uid":model.uid,
                                               @"url":model.headurl,
                                          @"isMaster":model.ismaster.stringValue
                                              }];
    }
    _scrollView.contentSize = CGSizeMake(kLeftEdge+(kImageSize+kEdgeDistance)*array.count + 2.5, kViewHeight-0.5);
}

#pragma mark - joinButton

- (void)joinButtonClick:(UIButton *)sender {
//    [self routerEventWithName:@"" userInfo:@{}];
}

#pragma mark - 属性

- (UIView *)view {
    if (_view == nil) {
        _view = [UIView new];
        _view.backgroundColor = [UIColor whiteColor];
    }
    return _view;
}

- (UILabel *)upLine {
    if (_upLine == nil) {
        _upLine = [UILabel new];
        _upLine.backgroundColor = [ColorTools lineColor];
    }
    return _upLine;
}

- (UILabel *)downLine {
    if (_downLine == nil) {
        _downLine = [UILabel new];
        _downLine.backgroundColor = [ColorTools lineColor];
    }
    return _downLine;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor colorWithRed:239/255.0
                                                      green:239/255.0
                                                       blue:239/255.0
                                                      alpha:1];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

- (UIButton *)joinButton {
    if (_joinButton == nil) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinButton.backgroundColor = [UIColor whiteColor];
        [_joinButton setTitle:@"0人\n参与" forState:UIControlStateNormal];
        [_joinButton setTitleColor:[ColorTools titleColor] forState:UIControlStateNormal];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _joinButton.titleLabel.numberOfLines = 0;
        _joinButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_joinButton addTarget:self action:@selector(joinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

-(NSMutableArray *)portraitViewArray
{
    if (_portraitViewArray == nil)
    {
        _portraitViewArray = [NSMutableArray new];
        for ( int i = 0; i < 8; i++)
        {
            PortraitView *portraitView = [PortraitView new];
            [_portraitViewArray addObject:portraitView];
            portraitView.hidden = YES;
            portraitView.frame = CGRectMake(kLeftEdge + (kImageSize + kEdgeDistance) * i, kEdgeDistance, kImageSize, kImageSize);
            [self.scrollView addSubview:portraitView];
        }
    }
    return _portraitViewArray;
}

@end
