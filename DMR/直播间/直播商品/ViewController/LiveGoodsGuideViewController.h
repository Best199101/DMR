//
//  LiveGoodsGuideViewController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/15.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseViewController.h"
@class GoodsModel;

@interface LiveGoodsGuideViewController : UIViewController

-(instancetype)initWithModel:(GoodsModel *)model;

-(void)addTapAction:(SEL)selector Target:(id)target;

@end
