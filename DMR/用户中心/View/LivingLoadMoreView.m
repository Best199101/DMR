//
//  LivingLoadMoreView.m
//  happigo
//
//  Created by fei on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "LivingLoadMoreView.h"
#import "UIColor+HEX.h"
#import "UIResponder+Router.h"
#import "UIColor+HEX.h"

NSString *const livingLoadMore = @"livingLoadMore";

@interface LivingLoadMoreView ()

@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *line2;


@end

@implementation LivingLoadMoreView

-(instancetype)init{
    
    if (self = [super init]) {
        [self initSubViews];
        [self setLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initSubViews{
    [self addSubview:self.loadMore];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
}
-(void)setLayout{
    WeakObject(weakSelf);
    
    [self.loadMore mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.mas_top).offset(8);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.loadMore.mas_centerY);
        make.right.equalTo(weakSelf.loadMore.mas_left).offset(-10);
        make.height.equalTo(@0.5);
        make.width.equalTo(@20);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.loadMore.mas_centerY);
        make.left.equalTo(weakSelf.loadMore.mas_right).offset(10);
        make.height.equalTo(@0.5);
        make.width.equalTo(@20);
    }];

}



-(void)loadAction{
    [self routerEventWithName:livingLoadMore userInfo:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIButton *)loadMore{
    if (_loadMore == nil) {
        _loadMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadMore setTitle:@"查看更多" forState:UIControlStateNormal];
        [_loadMore setTitleColor:[UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1.0] forState:UIControlStateNormal];
        _loadMore.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:14];
        
    }
    return _loadMore;
}
-(UIView *)line1{
    if (_line1 == nil) {
        _line1 = [UIView new];
        _line1.backgroundColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.0];
        
    }
    return _line1;
}

-(UIView *)line2{
    if (_line2 == nil) {
        _line2 = [UIView new];
        _line2.backgroundColor =[UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.0];
        
    }
    return _line2;
}


@end
