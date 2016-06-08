//
//  UITableView+DMRRefresh.h
//  DMR
//
//  Created by 雨 on 16/6/2.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRRefreshGifHeader.h"
#import "DMRRefreshHeader.h"

@interface UITableView (DMRRefresh)

- (void)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (void)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
