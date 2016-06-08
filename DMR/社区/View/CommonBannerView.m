//
//  CommonBannerView.m
//  happigo
//
//  Created by shklxmac111 on 15/12/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "CommonBannerView.h"
#import "BannerView.h"
#import "CommonBannerModel.h"
#import "UIImageView+DMRLoading.h"
#import "UIResponder+Router.h"
#import "Global.h"

NSString *const bannerImageViewLeft = @"bannerImageViewLeft";
NSString *const bannerImageViewRight = @"bannerImageViewRight";


@interface CommonBannerView ()

@property (strong,nonatomic) BannerView *bannerView;
@property (strong,nonatomic) UIImageView *leftImageView;
@property (strong,nonatomic) UIImageView *rightImageView;
@property (strong,nonatomic) CommonBannerModel *model;

@end

@implementation CommonBannerView

-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bannerView];
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
        WeakObject(weakSelf);
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.height.equalTo(@(DeviceWidth * 0.21));
            make.top.equalTo(weakSelf.mas_top);
        }];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.top.equalTo(_bannerView.mas_bottom).with.offset(5);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.equalTo(@((DeviceWidth - 5)/2));
        }];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(_bannerView.mas_bottom).with.offset(5);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.width.equalTo(@((DeviceWidth - 5)/2));
        }];

    }
    return self;
}

-(void)setContentWithModel:(CommonBannerModel *)model
{
}

-(void)leftTap
{
    [self routerEventWithName:bannerImageViewLeft
                     userInfo:nil];
}

-(void)rightTap
{
    [self routerEventWithName:bannerImageViewRight
                     userInfo:nil];
}

+(CGFloat)heightForCommonBannerView
{
    return DeviceWidth * 0.435;
}
-(BannerView *)bannerView
{
    if (_bannerView == nil)
    {
        _bannerView = [BannerView new];
        _bannerView.userInteractionEnabled = YES;
    }
    return _bannerView;
}

-(UIImageView*)leftImageView
{
    if (_leftImageView == nil)
    {
        _leftImageView = [UIImageView new];
        _leftImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc]initWithTarget:self
                                               action:@selector(leftTap)];
        [_leftImageView addGestureRecognizer:tap];
    }
    return _leftImageView;
}

-(UIImageView*)rightImageView
{
    if (_rightImageView == nil)
    {
        _rightImageView = [UIImageView new];
        _rightImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc]initWithTarget:self
                                               action:@selector(rightTap)];
        [_rightImageView addGestureRecognizer:tap];

        
    }
    return _rightImageView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
