//
//  PersonLevelView.m
//  happigo
//
//  Created by fei on 16/2/26.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonLevelView.h"
#import "UIResponder+Router.h"
#import "UIColor+HEX.h"

NSString *const personLevelHiddenTap = @"personLevelHiddenTap";


@interface PersonLevelView ()

@property(nonatomic, strong) UILabel *sufferLabel;

@property(nonatomic, strong) UIView *sufferView;
@property(nonatomic, strong) UIButton *hiddenButton;


@end


@implementation PersonLevelView


-(instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
        [self setLayoutSubviews];
        self.backgroundColor = [UIColor colorWithRed:242/255. green:251/255. blue:250/255. alpha:1.0];
    }
    return self;
}


-(void)initSubviews{
    
    [self addSubview:self.sufferLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.sufferView];
    [self addSubview:self.hiddenButton];
    
}

-(void)setLayoutSubviews{
    
    WeakObject(weakSelf);
    [self.sufferLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.height.equalTo(@15);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-8);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.width.equalTo(weakSelf.mas_width).offset(-20);
        make.height.equalTo(@5);
    }];
    [self.sufferView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.bottom.equalTo(weakSelf.lineView);
        make.width.equalTo(@0.1);
    }];
    [self.hiddenButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.sufferLabel.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    

}


-(void)setContentWithLevel:(PersonLevelModel *)model{

    CGFloat levels;
    WeakObject(weakSelf);
    
    // lineView会无缘无故的消失，应该是布局出了问题
    
    if (MainTabBar.currentUser.level.intValue == 1) {
            
        self.sufferLabel.text = [NSString stringWithFormat:@"经验值：%d/%d",[MainTabBar.currentUser.experience intValue] - [model.experience_from intValue], [model.experience_to intValue] - [model.experience_from intValue]];
            
        levels = ([MainTabBar.currentUser.experience floatValue] - [model.experience_from floatValue]) / (model.experience_to.floatValue - model.experience_from.floatValue);
            
        } else {
            
        self.sufferLabel.text = [NSString stringWithFormat:@"经验值：%d/%d",[MainTabBar.currentUser.experience intValue] - [model.experience_from intValue] + 1, [model.experience_to intValue] - [model.experience_from intValue] + 1];
        levels = ([MainTabBar.currentUser.experience floatValue] - [model.experience_from floatValue] + 1) / (model.experience_to.floatValue - model.experience_from.floatValue + 1);
        }
    
    [self.sufferView mas_updateConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(weakSelf.lineView.mas_width).multipliedBy(levels);
    }];
}

-(void)hiddenButtonAction
{
    [self routerEventWithName:personLevelHiddenTap userInfo:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(UILabel *)sufferLabel{
    if (_sufferLabel == nil) {
        _sufferLabel = [UILabel new];
        _sufferLabel.textColor = [UIColor colorWithHex:0x1c6c62 alpha:1.0];
        _sufferLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:12];
        
    }
    return _sufferLabel;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:105/255. green:209/255. blue:195/255. alpha:1.0];
        _lineView.layer.cornerRadius = 2.5;
        
    }
    return _lineView;
}

-(UIView *)sufferView{
    if (_sufferView == nil) {
        _sufferView = [UIView new];
        _sufferView.backgroundColor = [UIColor colorWithRed:255/255. green:110/255. blue:155/255. alpha:1.0f];
        _sufferView.layer.cornerRadius = 2.5;
        
    }
    return _sufferView;
}

-(UIButton *)hiddenButton{
    if (_hiddenButton == nil) {
        _hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_hiddenButton addTarget:self action:@selector(hiddenButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenButton;
}


@end
