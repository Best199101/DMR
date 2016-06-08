//
//  TweetAttentionCell.m
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "TweetAttentionCell.h"
#import "PortraitView.h"
#import "ColorTools.h"
#import "UIResponder+Router.h"
#import "AttentionModel.h"
#import "Global.h"

#define kTopPadding 15
#define kPadding 10
#define kWidth 36

//NSString *const AttentionButtonTap  = @"AttentionButtonTap";



@interface TweetAttentionCell ()

@property (nonatomic, strong) PortraitView *portraitView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation TweetAttentionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    [self.contentView addSubview:self.portraitView];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.attentionButton];
    [self.contentView addSubview:self.lineView];
}

-(void)setLayouts{
    WeakObject(weakSelf);
    [self.portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopPadding);
        make.left.mas_equalTo(kPadding);
        make.size.mas_equalTo(CGSizeMake(kWidth, kWidth));
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.portraitView.mas_top);
        make.left.equalTo(weakSelf.portraitView.mas_right).offset(kPadding);
        make.height.mas_equalTo(kWidth/2);
        make.width.lessThanOrEqualTo(@(weakSelf.contentView.bounds.size.width - 140));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nickNameLabel.mas_bottom);
        make.left.equalTo(weakSelf.portraitView.mas_right).offset(kPadding);
        make.height.mas_equalTo(kWidth/2);
        make.width.lessThanOrEqualTo(@(weakSelf.contentView.bounds.size.width - 140));
    }];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-kPadding);
        make.size.mas_equalTo(CGSizeMake(61, 23));
        make.centerY.equalTo(weakSelf.portraitView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - 公有方法

-(void)setContentWithModel:(AttentionModel *)attentionModel{
    [self.portraitView setContentWithUserInfo:@{@"url":attentionModel.headurl}];
    [self.nickNameLabel setText:attentionModel.nickname];
    [self.tagLabel setText:attentionModel.desc];
    [self.attentionButton setTitle:@"+关注" forState:UIControlStateNormal];
}

-(CGFloat)getHeightWithModel:(AttentionModel *)attentionModel{
    return 66;
}
#pragma mark - 事件

-(void)attention
{
    [self routerEventWithName:@"attentionButton" userInfo:nil];
}

#pragma mark - 属性

-(PortraitView *)portraitView{
    if (nil == _portraitView) {
        _portraitView = [[PortraitView alloc] init];
    }
    return _portraitView;
}

-(UILabel *)nickNameLabel{
    if (nil == _nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.textColor = [ColorTools nickNameColor];
    }
    return _nickNameLabel;
}

-(UILabel *)tagLabel{
    if (nil == _tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = [ColorTools nickNameColor];
    }
    return _tagLabel;
}

-(UIButton *)attentionButton{
    if (nil == _attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton addTarget:self
                             action:@selector(attention)
                   forControlEvents:UIControlEventTouchUpInside];
        _attentionButton.layer.borderWidth = 1.0f;
        _attentionButton.layer.borderColor = [ColorTools lightTextColor].CGColor;
        [_attentionButton setTitleColor:[ColorTools lightTextColor] forState:UIControlStateNormal];
        _attentionButton.layer.cornerRadius = 3.0f;
    }
    return _attentionButton;
}

-(UIView *)lineView{
    if (nil == _lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [ColorTools textColor];
    }
    return _lineView;
}

@end
