//
//  PersonHeaderView.m
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonHeaderView.h"
#import "UIResponder+Router.h"
#import "UIImageView+DMRLoading.h"
#import "PersonLevelView.h"
#import "FXBlurView.h"
#import "UIImageEffects.h"
#import "ColorTools.h"
#import "UIColor+HEX.h"
#import "UIImageView+WebCache.h"

NSString *const PersonspaceHeaderTap = @"PersonspaceHeaderTap";
NSString *const PersonspaceDespTap = @"PersonspaceDespTap";
NSString *const PersonspaceLevelTap = @"PersonspaceLevelTap";
NSString *const PersonspaceCheckTap = @"PersonspaceCheckTap";
NSString *const PersonspaceSetTap = @"PersonspaceSetTap";
NSString *const PersonspacePersonTap = @"PersonspacePersonTap";
NSString *const PersonspaceConcernTap = @"PersonspaceConcernTap";
NSString *const PersonspaceFansTap = @"PersonspaceFansTap";
NSString *const PersonspaceLoginTap = @"PersonspaceLoginTap";

@interface PersonHeaderView ()

// 设置按钮
//@property(nonatomic, strong) UIButton *resetButton;
// 头像
@property(nonatomic, strong) UIImageView *headerButton;
// 达人
@property(nonatomic, strong) UIImageView *masterView;
// 签名
@property(nonatomic, strong) UIButton *despButton;
// 等级
@property(nonatomic, strong) UIButton *levelButton;
@property(nonatomic, strong) PersonLevelView *levelView;
//@property(nonatomic, strong) UIImageView *bgLevelView;
// 登录
@property(nonatomic, strong) UIButton *loginButton;
// 签到
@property(nonatomic, strong) UIButton *checkButton;
@property(nonatomic, strong) UIButton *checkedButton;

// 背景
@property(nonatomic, strong) UIImageView *BGView;

@property(nonatomic, strong) UIButton *spaceButton;
@property(nonatomic, strong) UIButton *concernButton;
@property(nonatomic, strong) UIButton *funsButton;
@property(nonatomic, strong) UIButton *spaceBGButton;
@property(nonatomic, strong) UIButton *concernBGButton;
@property(nonatomic, strong) UIButton *funBGButton;

// 分割线
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UILabel *experienceNumber;

@end

@implementation PersonHeaderView


- (instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
        [self setLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.BGView];
//    [self addSubview:self.resetButton];
    [self addSubview:self.headerButton];
    [self addSubview:self.masterView];
    [self addSubview:self.despButton];
    [self addSubview:self.levelButton];
    [self addSubview:self.loginButton];
    [self addSubview:self.checkButton];
    [self addSubview:self.checkedButton];
    [self addSubview:self.experienceNumber];
    [self addSubview:self.spaceButton];
    [self addSubview:self.concernButton];
    [self addSubview:self.funsButton];
    [self addSubview:self.spaceNumber];
    [self addSubview:self.concernNumber];
    [self addSubview:self.funsNumber];
    [self addSubview:self.line];
    [self addSubview:self.line2];
    [self addSubview:self.spaceBGButton];
    [self addSubview:self.concernBGButton];
    [self addSubview:self.funBGButton];
//    [self bringSubviewToFront:self.bgLevelView];
    
}

- (void)setLayout{
    
    WeakObject(weakSelf);
    
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@90);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.BGView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.BGView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WindowSize.width, 0.5));
        
    }];

    [self.headerButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.BGView.mas_centerY);
        make.left.equalTo(weakSelf.BGView.mas_left).offset(17);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    
    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.headerButton.mas_centerX).offset(21.13);
        make.centerY.equalTo(weakSelf.headerButton.mas_centerY).offset(21.13);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
        
    }];

    
    [self.despButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.headerButton.mas_right).offset(9);
        make.top.equalTo(weakSelf.loginButton.mas_top).offset(0);
        make.height.equalTo(@22);
        make.width.greaterThanOrEqualTo(@0.1);
        
        
    }];
    [self.levelButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.despButton.mas_top);
        make.left.equalTo(weakSelf.despButton.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(35, 22));
        
    }];
    
  
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(weakSelf.headerButton.mas_centerY).offset(-5);
        make.left.equalTo(weakSelf.headerButton.mas_right).offset(5);
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];

    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.headerButton.mas_right).offset(9);
        make.top.equalTo(weakSelf.headerButton.mas_centerY).offset(4.5);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    
    [self.checkedButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.checkButton.mas_left).offset(0);
        make.centerY.equalTo(weakSelf.checkButton.mas_centerY);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.greaterThanOrEqualTo(@0.1);

    }];

   
    [self.experienceNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.checkButton.mas_right).offset(15);
        make.centerY.equalTo(weakSelf.checkButton.mas_centerY);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];

    
    [self.spaceNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.BGView.mas_bottom).offset(11.25);
        make.centerX.equalTo(weakSelf.BGView.mas_right).multipliedBy(0.16666667);
        make.height.equalTo(@15);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.spaceButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.spaceNumber.mas_bottom).offset(5);
        make.centerX.equalTo(weakSelf.spaceNumber.mas_centerX);
        make.height.equalTo(@10);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.spaceBGButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.spaceNumber.mas_top);
        make.bottom.equalTo(weakSelf.spaceButton.mas_bottom);
        make.width.equalTo(weakSelf.spaceButton.mas_width);
        make.centerX.equalTo(weakSelf.spaceButton.mas_centerX);
    }];
    
    [self.concernNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.spaceNumber.mas_top);
        make.centerX.equalTo(weakSelf.BGView.mas_right).multipliedBy(0.5);
        make.height.equalTo(@15);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.concernButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.concernNumber.mas_bottom).offset(5);
        make.centerX.equalTo(weakSelf.concernNumber.mas_centerX);
        make.height.equalTo(@10);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.concernBGButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.concernNumber.mas_top);
        make.bottom.equalTo(weakSelf.concernButton.mas_bottom);
        make.width.equalTo(weakSelf.concernButton.mas_width);
        make.centerX.equalTo(weakSelf.concernButton.mas_centerX);
    }];

    
    [self.funsNumber mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.spaceNumber.mas_top);
        make.centerX.equalTo(weakSelf.BGView.mas_right).multipliedBy(0.83333333);
        make.height.equalTo(@15);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.funsButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.funsNumber.mas_bottom).offset(5);
        make.centerX.equalTo(weakSelf.funsNumber.mas_centerX);
        make.height.equalTo(@10);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];
    
    [self.funBGButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.funsNumber.mas_top);
        make.bottom.equalTo(weakSelf.funsButton.mas_bottom);
        make.width.equalTo(weakSelf.funsButton.mas_width);
        make.centerX.equalTo(weakSelf.funsButton.mas_centerX);
    }];

    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.spaceButton.mas_bottom).offset(11.25);
        make.height.equalTo(@14);
        make.left.right.equalTo(weakSelf);
        
    }];
    
}




-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
        [self.nextResponder routerEventWithName:eventName userInfo:userInfo];
    

}

// 点击事件分发

- (void)resetAction{
    
    [self routerEventWithName:PersonspaceSetTap userInfo:nil];
}
- (void)headerAction{
    [self routerEventWithName:PersonspaceHeaderTap userInfo:nil];
}
- (void)despAction{
    [self routerEventWithName:PersonspaceDespTap userInfo:nil];
}
- (void)levelAction{

    if (self.levelView) {
        [self removeLevelView];
        return;
    }
    [self addLevelView];
    [self routerEventWithName:PersonspaceLevelTap userInfo:nil];
}

- (void)loginAction{
    [self routerEventWithName:PersonspaceLoginTap userInfo:nil];
}
- (void)checkAction{
    [self routerEventWithName:PersonspaceCheckTap userInfo:nil];
}
- (void)spaceAction{
    [self routerEventWithName:PersonspacePersonTap userInfo:nil];
}
- (void)concernAction{
    [self routerEventWithName:PersonspaceConcernTap userInfo:nil];
}
- (void)funsAction{
    [self routerEventWithName:PersonspaceFansTap userInfo:nil];
}


// 配置内容
-(void)setContentWithModel:(PersonInfoModel *)model{
    
    
    if (MainTabBar.currentUser.uid.length) {

        self.loginButton.hidden = YES;
        self.despButton.hidden = NO;
        self.levelButton.hidden = NO;
        self.experienceNumber.hidden = NO;

        if (MainTabBar.currentUser.isSign.intValue) {
            self.checkButton.hidden = YES;
            self.checkedButton.hidden = NO;

        } else{
            self.checkButton.hidden = NO;
            [self.checkButton setImage:[UIImage imageNamed:@"btn_personal_center_sign"] forState:UIControlStateNormal];
            self.checkedButton.hidden = YES;
        }
        
        if (model.is_master.intValue) {
            self.masterView.hidden = NO;
        } else{
            self.masterView.hidden = YES;
        }
        [self.headerButton sd_setImageWithURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KResoureURL,MainTabBar.currentUser.head_img_url]]
                             placeholderImage:[UIImage imageNamed:@"avatar_shequ_default_headimg"]
                                      options:SDWebImageRefreshCached
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         
                                     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                         [self refreshBlurViewForNewImage:image];
                                     }];
        
        
        
        [self.despButton setTitle:MainTabBar.currentUser.nickname forState:UIControlStateNormal];

        // 积分
        self.experienceNumber.text = [NSString stringWithFormat:@"积分：%@", model.jfNo == nil ? @"0" : model.jfNo];
        // 等级
        int level = MainTabBar.currentUser.level.intValue;
        NSString *levelStr = [NSString stringWithFormat:@"ico_shequ_level%d", level];
        [self.levelButton setImage:[UIImage imageNamed:levelStr] forState:UIControlStateNormal];
        
        // 主页数
        self.spaceNumber.text = [NSString stringWithFormat:@"%d",  model.topicNum.intValue + model.topicVideoNum.intValue + model.qukVideoNum.intValue];
        
        // 关注数
        NSString *concernStr = [NSString stringWithFormat:@"%d", model.concernNum.intValue];
        self.concernNumber.text = concernStr;
        
        // 粉丝数
        NSString *funNumberStr = [NSString stringWithFormat:@"%d", model.myFanNum.intValue];
        self.funsNumber.text = funNumberStr;
    
    } else{
        
        self.despButton.hidden = YES;
        self.levelButton.hidden = YES;
        self.loginButton.hidden = NO;
        self.checkButton.hidden = NO;
        self.experienceNumber.hidden = YES;
        [self.checkButton setImage:[UIImage imageNamed:@"btn_presonal_center_unlogin_sign"] forState:UIControlStateNormal];
        self.masterView.hidden = YES;
        self.checkedButton.hidden = YES;
        self.concernNumber.text = @"0";
        self.spaceNumber.text = @"0";
        self.funsNumber.text = @"0";
        UIImage *IMG = [UIImage imageNamed:@"avatar_shequ_default_headimg"];
        self.headerButton.image = IMG;
    }
    
}

-(void)setContentWithLevelModel:(PersonLevelModel *)model{
    
    [self.levelView setContentWithLevel:model];
    
}


-(void)hidenAction{
        
    if (self.levelView) {
        [self removeLevelView];
    }

}

-(void)refreshBlurViewForNewImage:(UIImage *)img{
    
    if (img) {
//        UIImage *blurScreenShot = [UIImageEffects imageByApplyingBlurToImage:img withRadius:45 tintColor:[UIColor colorWithWhite:0.6 alpha:.2] saturationDeltaFactor:1.0 maskImage:nil];
        self.BGView.image = img;
//        self.headerButton.image = img;
    }
    
}

// 添加等级view
-(void)addLevelView{
    
    WeakObject(weakSelf);
    self.levelView = [PersonLevelView new];
    self.levelView.layer.cornerRadius = 5;
    [self addSubview:self.levelView];
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.despButton.mas_bottom).offset(3);
        make.left.equalTo(weakSelf.despButton.mas_left);
        make.height.equalTo(@43);
        make.right.equalTo(weakSelf.mas_right).offset(-17);
        
    }];
}
// 移除等级View
-(void)removeLevelView{
    
    [self.levelView removeFromSuperview];
    self.levelView = nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//-(UIButton *)resetButton{
//    if (_resetButton == nil) {
//        _resetButton = [UIButton new];
//
//        [_resetButton setImage:[UIImage imageNamed:@"btn_personal_center_set"] forState:UIControlStateNormal];
//        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _resetButton;
//}
-(UIImageView *)headerButton{
    if (_headerButton == nil) {
        _headerButton = [UIImageView new];
        _headerButton.layer.cornerRadius = 30;
        _headerButton.clipsToBounds = YES;
        _headerButton.image = [UIImage imageNamed:@"avatar_shequ_default_headimg"];
        UITapGestureRecognizer *arrowTap = [[UITapGestureRecognizer alloc] init];
        [arrowTap addTarget:self action:@selector(headerAction)];
        [_headerButton addGestureRecognizer:arrowTap];
        _headerButton.userInteractionEnabled = YES;

    }
    return _headerButton;
}
-(UIButton *)despButton{
    if (_despButton == nil) {
        _despButton = [UIButton new];
//        _despButton.backgroundColor = [UIColor redColor];
        [_despButton setTitle:@"ahsjdh" forState:UIControlStateNormal];
        [_despButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0]forState:UIControlStateNormal];
//        _despButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _despButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_despButton addTarget:self action:@selector(despAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _despButton;
}

-(UIButton *)levelButton{
    if (_levelButton == nil) {
        _levelButton = [UIButton new];
        [_levelButton setImage:[UIImage imageNamed:@"ico_shequ_level11"] forState:UIControlStateNormal];
        _levelButton.backgroundColor = [UIColor clearColor];
        [_levelButton addTarget:self action:@selector(levelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _levelButton;
}
-(UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton new];
        [_loginButton setTitle:@" 登录 / 注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
//        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
//        _loginButton.backgroundColor = [UIColor yellowColor];
    }
    return _loginButton;
}
-(UIButton *)checkButton{
    if (_checkButton == nil) {
        _checkButton = [UIButton new];
//        _checkButton.backgroundColor = [UIColor redColor];
        _checkButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [_checkButton setImage:[UIImage imageNamed:@"btn_personal_center_sign"] forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}

-(UIButton *)checkedButton{
    if (_checkedButton == nil) {
        _checkedButton = [UIButton new];
        //        _checkButton.backgroundColor = [UIColor redColor];
        _checkedButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [_checkedButton setImage:[UIImage imageNamed:@"btn_personal_center_signed"] forState:UIControlStateNormal];
        [_checkedButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
//        _checkedButton.imageView.
//        [_checkedButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkedButton;
}


-(UIButton *)spaceButton{
    if (_spaceButton == nil) {
        _spaceButton = [UIButton new];
//        _spaceButton.backgroundColor = [UIColor redColor];
        [_spaceButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
//        _spaceButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
        _spaceButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _spaceButton.backgroundColor = [UIColor clearColor];
//        [_spaceButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       [_spaceButton setTitle:@"个人主页" forState:UIControlStateNormal];
        [_spaceButton addTarget:self action:@selector(spaceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _spaceButton;
}

- (UIButton *)concernButton{
    if (_concernButton == nil) {
        _concernButton = [UIButton new];
//        _concernButton.backgroundColor = [UIColor redColor];
        [_concernButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
//        _concernButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
        _concernButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _concernButton.backgroundColor = [UIColor clearColor];
//        [_concernButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_concernButton setTitle:@"关注的人" forState:UIControlStateNormal];
        [_concernButton addTarget:self action:@selector(concernAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _concernButton;
}

- (UIButton *)funsButton{
    if (_funsButton == nil) {
        _funsButton = [UIButton new];
//        _funsButton.backgroundColor = [UIColor redColor];
        [_funsButton setTitleColor:[UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0] forState:UIControlStateNormal];
//        _funsButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
        _funsButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _funsButton.backgroundColor = [UIColor clearColor];
//        [_funsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_funsButton setTitle:@"我的粉丝" forState:UIControlStateNormal];
        [_funsButton addTarget:self action:@selector(funsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funsButton;
}

- (UILabel *)spaceNumber{
    if (_spaceNumber == nil) {
        _spaceNumber = [UILabel new];
        _spaceNumber.text = @"0";
        _spaceNumber.textColor = [UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0];
        _spaceNumber.font = [UIFont fontWithName:@"Regular" size:28];
        _spaceNumber.font = [UIFont systemFontOfSize:14];
        
    }
    return _spaceNumber;
}

- (UILabel *)concernNumber{
    if (_concernNumber == nil) {
        _concernNumber = [UILabel new];
        _concernNumber.text = @"0";
        _concernNumber.textColor = [UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0];
        _concernNumber.font = [UIFont fontWithName:@"Regular" size:28];
        _concernNumber.font = [UIFont systemFontOfSize:14];
        
    }
    return _concernNumber;
}

- (UILabel *)funsNumber{
    if (_funsNumber == nil) {
        _funsNumber = [UILabel new];
        _funsNumber.text = @"0";
        _funsNumber.textColor = [UIColor colorWithRed:54/255. green:54/255. blue:54/255. alpha:1.0];
        _funsNumber.font = [UIFont fontWithName:@"Regular" size:28];
        _funsNumber.font = [UIFont systemFontOfSize:14];
    }
    return _funsNumber;
}

- (UIImageView *)BGView{
    if (_BGView == nil) {
        _BGView = [UIImageView new];
        _BGView.backgroundColor = [UIColor whiteColor];
//        _BGView.image = [UIImage imageNamed:@"user_center_bg"];
//        [_BGView sd_setImageWithURL:[NSURL URLWithString:@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"] placeholderImage:nil completed:nil];
        
    }
    return _BGView;
}


-(UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.0];
    }
    return _line;
}

-(UIView *)line2{
    if (_line2 == nil) {
        _line2 = [UIView new];
        _line2.backgroundColor = [UIColor colorWithRed:209/255. green:209/255. blue:209/255. alpha:1.0];
    }
    return _line2;
}
-(UIImageView *)masterView{
    if (_masterView == nil) {
        _masterView = [UIImageView new];
        _masterView.image = [UIImage imageNamed:@"icon_rank_v"];
        
    }
    return _masterView;
}

- (UIButton *)funBGButton{
    if (_funBGButton == nil) {
        _funBGButton = [UIButton new];
        _funBGButton.backgroundColor = [UIColor clearColor];
        [_funBGButton addTarget:self action:@selector(funsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funBGButton;
}

-(UIButton *)spaceBGButton{
    if (_spaceBGButton == nil) {
        _spaceBGButton = [UIButton new];
        _spaceBGButton.backgroundColor = [UIColor clearColor];
        [_spaceBGButton addTarget:self action:@selector(spaceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _spaceBGButton;
}

- (UIButton *)concernBGButton{
    if (_concernBGButton == nil) {
        _concernBGButton = [UIButton new];
        _concernBGButton.backgroundColor = [UIColor clearColor];
        [_concernBGButton addTarget:self action:@selector(concernAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _concernBGButton;
}

-(UILabel *)experienceNumber{
    if (_experienceNumber == nil) {
        _experienceNumber = [UILabel new];
//        _experienceNumber.text = @"0";
        _experienceNumber.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        _experienceNumber.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1.0];
    }
    return _experienceNumber;
}

//-(UIImageView *)bgLevelView{
//    if (_bgLevelView == nil) {
//        _bgLevelView = [UIImageView new];
//        _bgLevelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        _bgLevelView.hidden = YES;
//        _bgLevelView.userInteractionEnabled = YES;
//        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        [_bgLevelView addGestureRecognizer:tap];
//    }
//    return _bgLevelView;
//}

@end
