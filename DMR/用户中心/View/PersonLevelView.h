//
//  PersonLevelView.h
//  happigo
//
//  Created by fei on 16/2/26.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonLevelModel.h"

extern NSString *const personLevelHiddenTap;


@interface PersonLevelView : UIView
// 经验条背景
@property(nonatomic, strong) UIView *lineView;
-(void)setContentWithLevel:(PersonLevelModel *)model;


@end
