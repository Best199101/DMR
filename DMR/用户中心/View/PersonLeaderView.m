//
//  PersonLeaderView.m
//  happigo
//
//  Created by fei on 16/3/24.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonLeaderView.h"
#import "UIResponder+Router.h"

@interface PersonLeaderView ()

@property(nonatomic, strong) UIImageView *topView;
@property(nonatomic, strong) UIImageView *bgWhiteView;
@property(nonatomic, strong) UIImageView *bgGrayView;
@property(nonatomic, strong) UIImageView *betweentView;
//@property(nonatomic, strong) UIImageView *bottomView;


@end


@implementation PersonLeaderView

-(instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
        [self setLayoutSubviews];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}


-(void)initSubviews{
    [self addSubview:self.topView];
    [self addSubview:self.bgWhiteView];
    [self addSubview:self.betweentView];
    [self addSubview:self.bgGrayView];
//    [self addSubview:self.bottomView];
}

-(void)setLayoutSubviews{
    
    WeakObject(weakSelf);
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(-2);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.greaterThanOrEqualTo(@0.1);
        
    }];

    [self.bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(weakSelf.topView.mas_bottom);
        make.top.equalTo(weakSelf.mas_top).offset(154);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(weakSelf);
//        make.height.greaterThanOrEqualTo(@0.1);
        make.height.equalTo(@53);
        
    }];
    [self.betweentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.bgWhiteView.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.height.greaterThanOrEqualTo(@0.1);
        
    }];
    [self.bgGrayView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.betweentView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];

//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.right.bottom.equalTo(weakSelf).offset(-2);
//        make.height.greaterThanOrEqualTo(@0.1);
//        make.width.greaterThanOrEqualTo(@0.1);
//    }];
    
}

-(void)tapAction{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(UIImageView *)topView{
    if (_topView == nil) {
        _topView = [UIImageView new];
        _topView.image = [UIImage imageNamed:@"pic_presonal_center_guide_top"];
//        _topView.contentMode = UIViewContentModeScaleAspectFill;
        _topView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_topView addGestureRecognizer:tap];
    }
    return _topView;
}
-(UIImageView *)bgWhiteView{
    if (_bgWhiteView == nil) {
        _bgWhiteView = [UIImageView new];
        _bgWhiteView.image = [UIImage imageNamed:@"pic_presonal_center_guide_btn1"];
        _bgWhiteView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_bgWhiteView addGestureRecognizer:tap];
    }
    return _bgWhiteView;
}

-(UIImageView *)betweentView{
    if (_betweentView == nil) {
        _betweentView = [UIImageView new];
        _betweentView.image = [UIImage imageNamed:@"pic_presonal_center_guide_middle"];
//        _betweentView.contentMode = UIViewContentModeScaleAspectFill;
        _betweentView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_betweentView addGestureRecognizer:tap];
    }
    return _betweentView;
}
-(UIImageView *)bgGrayView{
    if (_bgGrayView == nil) {
        _bgGrayView = [UIImageView new];
//        _bgGrayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _bgGrayView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_bgGrayView addGestureRecognizer:tap];
    }
    return _bgGrayView;
}

//-(UIImageView *)bottomView{
//    if (_bottomView == nil) {
//        _bottomView = [UIImageView new];
//        _bottomView.image = [UIImage imageNamed:@"pic_presonal_center_guide_btn-1"];
////        _bottomView.contentMode = UIViewContentModeScaleAspectFill;
//        _bottomView.userInteractionEnabled = YES;
//        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        [_bottomView addGestureRecognizer:tap];
//    }
//    return _bottomView;
//}




@end
