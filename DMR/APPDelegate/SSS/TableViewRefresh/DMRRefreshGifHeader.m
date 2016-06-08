//
//  DMRRefreshGifHeader.m
//  DMR
//
//  Created by 雨 on 16/6/2.
//  Copyright © 2016年 wangzitao. All rights reserved.
//

#import "DMRRefreshGifHeader.h"

@implementation DMRRefreshGifHeader

- (void)prepare {
    [super prepare];
    
    //设置图片
    NSMutableArray *refreshImgs = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load_common_type1_%ld",i]];
        [refreshImgs addObject:image];
    }
    [self setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshStatePulling];
    [self setImages:refreshImgs forState:MJRefreshStateRefreshing];
    
    //设置内容
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"放开我~，我要刷新啦~" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
}

@end
