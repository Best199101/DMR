//
//  UITableView+HeaderGif.m
//  happigo
//
//  Created by 李海龙 on 16/1/11.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "UITableView+HeaderGif.h"
#import "MJRefresh.h"

@implementation UITableView (HeaderGif)


//-(void)setGifHeader:(BOOL)gif{
//    if (gif)
//    {
//        NSMutableArray *gifImageArray = [NSMutableArray new];
//        for (int i = 1 ; i < 9 ; i++) {
//            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"load_common_type1_%d",i]];
//            [gifImageArray addObject:img];
//        }
//        self.scrollsToTop = YES;
//        [self.gifHeader setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshHeaderStateIdle];
//        [self.gifHeader setImages:@[[UIImage imageNamed:@"load_common_type1_1"]] forState:MJRefreshHeaderStatePulling];
//        [self.gifHeader setImages:gifImageArray forState:MJRefreshHeaderStateRefreshing];
//    }
//}

@end
