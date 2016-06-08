//
//  SegmentView.h
//  DMR
//
//  Created by shklxjsbmac004 on 15/12/28.
//  Copyright © 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const titleLabelTap;

@interface SegmentView : UIView

//当前选择的标题索引值
@property (assign,nonatomic) NSInteger selectedIndex;

//根据标题数组初始化视图
- (instancetype)initSegmentViewWithTitleItems:(NSArray *)items;

@end
