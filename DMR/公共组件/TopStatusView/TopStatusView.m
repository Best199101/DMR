//
//  TopStatusView.m
//  xiaoqu
//
//  Created by wendy on 15/6/15.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#define kTopStatusHeight 64
#define __kWidth                        [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#import "TopStatusView.h"
#import <Masonry/Masonry.h>

@interface TopStatusView ()

@property (strong,nonatomic) UILabel* label;
@property (strong,nonatomic) UILabel* addressLabel;
@property (assign) SectionType type;
@property (nonatomic, strong)hiddenCallBack finishCallBack;
@end

@implementation TopStatusView



-(id)initWithType:(SectionType)type
{
    if (self = [super init]) {
        [self initSubViews];
        [self setLayouts];
        _type = type;
        if (_type == SectionUnderStatuBar) self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
        else if (_type == SectionUnderNaviBar) self.frame = CGRectMake(0, 64, __kWidth, kTopStatusHeight);
        else if (_type == SectionUnderTop) self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);

        self.alpha = 0.f;
    }
    return self;
}

-(instancetype)initWithViewController:(UIViewController*)viewcontroller
{
    if (self = [super init]) {
        [self initSubViews];
        [self setLayouts];
        self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
        _type = SectionUnderNaviBar;
        self.alpha = 0.f;
    }
    return self;
}

- (void)setupTopStatusData
{
    [self initSubViews];
    [self setLayouts];
    self.alpha = 0.f;
    self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
    _type = SectionUnderTop;
}

-(void)initSubViews
{
    _addressLabel = [UILabel new];
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.font = [UIFont boldSystemFontOfSize:16];
    _addressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_addressLabel];
}

-(void)setLayouts
{
    WS(weakSelf);
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(10,0,0,0));
    }];
}

- (void)hideWithCallBack:(hiddenCallBack)callback afterDelay:(NSTimeInterval)secondes
{
    if (callback) {
        self.finishCallBack = callback;
    }
    [self hide:YES afterDelay:secondes];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(hideDelayed:)
               withObject:[NSNumber numberWithBool:animated]
               afterDelay:delay];
}

- (void)hideDelayed:(NSNumber *)animated
{
    [self hide:[animated boolValue]];
}

- (void)hide:(BOOL)animated
{
    [self hideUsingAnimation:animated];
}

- (void)hideUsingAnimation:(BOOL)animated
{
    if (animated)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        self.alpha = 0.0f;
        self.frame = CGRectMake(0, -kTopStatusHeight, __kWidth, kTopStatusHeight);
        [UIView commitAnimations];
    }
    else
    {
        self.alpha = 0.0f;
        [self done];
    }
}

- (void)animationFinished:(NSString *)animationID
                 finished:(BOOL)finished
                  context:(void*)context
{
    [self done];
}

- (void)done
{
    self.alpha = 0.0f;
        [self removeFromSuperview];
    if (self.finishCallBack)
    {
        hiddenCallBack finish = self.finishCallBack;
        finish(YES);
        self.finishCallBack = nil;
    }
}

-(void)setStatusMessage:(NSString *)statusMessage
{
    _addressLabel.text = statusMessage;
}

- (void)setAtrributeStatusMessage:(NSAttributedString *)atrributeStatusMessage
{
    _addressLabel.attributedText = atrributeStatusMessage;
}

-(void)showOnSuperView
{
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    //以下四种效果
    /*
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];//oglFlip, fromLeft
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];//oglFlip, fromRight
     [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
     [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
     */
    self.alpha = 1.0f;
    if (_type == SectionUnderStatuBar) self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
    else if (_type == SectionUnderNaviBar) self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
    else if (_type == SectionUnderTop) self.frame = CGRectMake(0, 0, __kWidth, kTopStatusHeight);
    [UIView commitAnimations];
}

@end
