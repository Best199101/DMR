//
//  TopStatusView.h
//  xiaoqu
//
//  Created by wendy on 15/6/15.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define StatusViewTag 8888

typedef NS_ENUM(NSInteger, SectionType){
    SectionUnderStatuBar,
    SectionUnderNaviBar,
    SectionUnderTop,      //手机顶部
};

typedef void(^hiddenCallBack)(BOOL isHidden);

@interface TopStatusView : UIView


@property (strong,nonatomic) NSString* statusMessage;
@property (strong, nonatomic) NSAttributedString *atrributeStatusMessage;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (void)showOnSuperView;
-(instancetype)initWithType:(SectionType)type;
-(instancetype)initWithViewController:(UIViewController*)viewcontroller;

- (void)hideWithCallBack:(hiddenCallBack)callback afterDelay:(NSTimeInterval)secondes;

- (void)setupTopStatusData;

@end
