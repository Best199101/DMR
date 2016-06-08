//
//  PersonHeaderView.h
//  happigo
//
//  Created by fei on 16/2/17.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonLevelModel.h"
#import "PersonInfoModel.h"

extern NSString *const PersonspaceHeaderTap;
extern NSString *const PersonspaceDespTap;
extern NSString *const PersonspaceLevelTap;
extern NSString *const PersonspaceCheckTap;
extern NSString *const PersonspaceSetTap;
extern NSString *const PersonspacePersonTap;
extern NSString *const PersonspaceConcernTap;
extern NSString *const PersonspaceFansTap;
extern NSString *const PersonspaceLoginTap;



@interface PersonHeaderView : UIView

@property(nonatomic, strong) UILabel *spaceNumber;
@property(nonatomic, strong) UILabel *concernNumber;
@property(nonatomic, strong) UILabel *funsNumber;

// 配置表头
-(void)setContentWithModel:(PersonInfoModel *)model;
// 配置经验条
-(void)setContentWithLevelModel:(PersonLevelModel *)model;
// 是否隐藏levelView
-(void)hidenAction;

@end
