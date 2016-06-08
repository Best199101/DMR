//
//  PersonEnterLeaderView.m
//  happigo
//
//  Created by fei on 16/3/24.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "PersonEnterLeaderView.h"

@interface PersonEnterLeaderView ()

@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIImageView *bottomView;

@end

@implementation PersonEnterLeaderView

-(instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
        [self setLayoutSubviews];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}


-(void)initSubviews{
    [self addSubview:self.bgView];
    [self addSubview:self.bottomView];
}

-(void)setLayoutSubviews{
    
    WeakObject(weakSelf);

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.right.equalTo(weakSelf).offset(-2);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
    }];
    
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


-(UIImageView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIImageView new];
//        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _bgView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(UIImageView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [UIImageView new];
        _bottomView.image = [UIImage imageNamed:@"pic_presonal_center_guide_bottom"];
//        _bottomView.contentMode = UIViewContentModeScaleAspectFill;
        _bottomView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_bottomView addGestureRecognizer:tap];
    }
    return _bottomView;
}


@end
