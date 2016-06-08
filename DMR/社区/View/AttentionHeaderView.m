//
//  AttentionHeaderView.m
//  happigo
//
//  Created by 李海龙 on 15/12/30.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "AttentionHeaderView.h"
#import "Global.h"

NSString *const aleartSting = @"你还没有关注任何人哦~\n关注一些你感兴趣的人吧";

@interface AttentionHeaderView ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *aleartLabel;
@end

@implementation AttentionHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubViews];
        [self setLayouts];
    }
    return self;
}

#pragma mark - 私有方法

-(void)initSubViews{
    self.headerViewHeight = 210;
    [self addSubview:self.imageButton];
    [self addSubview:self.aleartLabel];
}

-(void)setLayouts{
    WeakObject(weakSelf);
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(25);
    }];
    [self.aleartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageButton.mas_bottom).offset(25);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(@(300));
        make.height.lessThanOrEqualTo(@(80));
    }];
}
#pragma mark - 属性

-(UIButton *)imageButton{
    if (nil == _imageButton) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.layer.cornerRadius = 50.0f;
        _imageButton.backgroundColor = [UIColor colorWithRed:235.0/255 green:253.0/255 blue:235.0/255 alpha:1.0f];
        _imageButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageButton.layer.borderWidth = 1.0f;
    }
    return _imageButton;
}

-(UILabel *)aleartLabel{
    if (nil == _aleartLabel) {
        _aleartLabel = [[UILabel alloc] init];
        _aleartLabel.font = [UIFont systemFontOfSize:14.0f];
        _aleartLabel.numberOfLines = 2;
        _aleartLabel.text = aleartSting;
        _aleartLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _aleartLabel;
}

@end
