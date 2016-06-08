//
//  FindViewController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(int, FindListType)
{
    FindListTypeAll = 0,     // 全部
    FindListTypeNew,         // 最新
    FindListTypeHottest,     // 热门
    FindListTypeAttention,   // 关注
};

@interface FindViewController : BaseViewController

- (instancetype)initWithFindListType:(FindListType)type;

@end
