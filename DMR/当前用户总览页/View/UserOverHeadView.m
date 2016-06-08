//
//  UserOverHeadView.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UserOverHeadView.h"
#import "PortraitView.h"
#import "UIView+Tools.h"
#import "ColorTools.h"
#import "UIButton+Badge.h"
#import "UIResponder+Router.h"


NSString *const UserOverHeadViewLeftButtonTapped  = @"UserOverHeadViewLeftButtonTapped";
NSString *const UserOverHeadViewRightButtonTapped = @"UserOverHeadViewRightButtonTapped";


@interface UserOverHeadView ()

@property (strong,nonatomic) PortraitView *portraitView;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *levelLabel;
@property (strong,nonatomic) UIButton *leftButton;
@property (strong,nonatomic) UIButton *rightButton;

@end

@implementation UserOverHeadView

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
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.portraitView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.levelLabel];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.height.equalTo(@44);
        make.width.equalTo(@50);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.height.equalTo(@44);
        make.width.equalTo(@50);
    }];
    
    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(40);
        make.height.equalTo(@(DeviceWidth/2 - 60));
        make.width.equalTo(@(DeviceWidth/2 - 60));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_portraitView.mas_bottom).with.offset(10);
        make.width.equalTo(weakSelf.mas_width);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@20);
    }];
    
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(3);
        make.width.equalTo(@30);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@13);
    }];
}

#pragma mark - 事件

-(void)leftButtonClick
{
    [self routerEventWithName:UserOverHeadViewLeftButtonTapped
                     userInfo:nil];
}

-(void)rightButtonClick
{
    [self routerEventWithName:UserOverHeadViewRightButtonTapped
                     userInfo:nil];
}

#pragma mark - 属性

-(PortraitView *)portraitView
{
    if (_portraitView == nil)
    {
        _portraitView = [PortraitView new];
        _portraitView.imageView.image = [UIImage imageNamed:@"setting"];
    }
    return _portraitView;
}

-(UIButton *)leftButton
{
    if (_leftButton == nil)
    {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"leftedit"]
                     forState:UIControlStateNormal];
        [_leftButton addTarget:self
                        action:@selector(leftButtonClick)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (_rightButton == nil)
    {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"setting"]
                      forState:UIControlStateNormal];
        [_rightButton addTarget:self
                         action:@selector(rightButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [ColorTools themePinkColor];
        _nameLabel.text = @"林志玲";
    }
    return _nameLabel;
}

-(UILabel *)levelLabel
{
    if (_levelLabel == nil)
    {
        _levelLabel = [UILabel new];
        _levelLabel.font = [UIFont systemFontOfSize:13];
        _levelLabel.textColor = [UIColor whiteColor];
        _levelLabel.backgroundColor = [UIColor purpleColor];
        [_levelLabel setCornerRadius:3];
    }
    return _levelLabel;
}

@end
