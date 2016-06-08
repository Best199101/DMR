//
//  PortraitView.m
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "PortraitView.h"
#import "UIResponder+Router.h"
#import "UIImageView+DMRLoading.h"
#import "Global.h"

NSString *const PortraitTap = @"PortraitTap";


@interface PortraitView ()

@property (strong,nonatomic) NSDictionary *userInfo;

@end

@implementation PortraitView

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
    [self addSubview:self.imageView];
    [self addSubview:self.tagView];
}

-(void)setLayouts
{
    WeakObject(weakSelf);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
}

-(void)tap
{
    [self routerEventWithName:PortraitTap
                     userInfo:_userInfo];
}

-(void)setContentWithUserInfo:(NSDictionary *)userInfo
{
    _userInfo = userInfo;
    [_imageView loadImageBySourceString:userInfo[@"url"]
                                 Header:KResoureURL
                                  width:70
                                 Height:70];
}

-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [UIImageView new];
        UITapGestureRecognizer *tapGestureRecognizer
        = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                 action:@selector(tap)];
        [_imageView addGestureRecognizer:tapGestureRecognizer];
        _imageView.userInteractionEnabled = YES;
        _imageView.cornerRadius = 17.5;
    }
    return _imageView;
}

-(UIImageView *)tagView
{
    if (_tagView == nil)
    {
        _tagView = [UIImageView new];
    }
    return _tagView;
}


@end
