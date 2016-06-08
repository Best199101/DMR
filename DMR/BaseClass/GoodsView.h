//
//  GoodsView.h
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

extern NSString * const LiveGoodsTapped;

@class GoodsModel;

@interface GoodsView : BaseView

@property (strong, nonatomic) GoodsModel *model;

-(void)setContentWithModel:(GoodsModel *)model;

@end
