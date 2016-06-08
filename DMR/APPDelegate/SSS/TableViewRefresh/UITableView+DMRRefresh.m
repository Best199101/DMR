//
//  UITableView+DMRRefresh.m
//  DMR
//
//  Created by 雨 on 16/6/2.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import "UITableView+DMRRefresh.h"

@implementation UITableView (DMRRefresh)

- (void)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    DMRRefreshGifHeader *gifHeader = [DMRRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    self.mj_header = gifHeader;
}

- (void)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    DMRRefreshHeader *header = [DMRRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    self.mj_header = header;
}

@end
