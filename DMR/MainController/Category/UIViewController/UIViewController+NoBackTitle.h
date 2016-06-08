//
//  UIViewController+NoNavBackTitle.h
//  HealthBracelets
//
//  Created by JulianChen on 14-8-4.
//  Copyright (c) 2014年 JulianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoBackTitleProtocol <NSObject>

@required

-(void)backBarButtonItemClicked;

@end

@interface UIViewController (NoBackTitle)
- (void)setNavigationBackItem;
- (void)setNavigationItemStyle;
@end
