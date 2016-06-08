//
//  LiveRoomViewController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(int, LiveListType)
{
    LiveListTypeAll = 0,    // 全部
    LiveListTypeLiving,     // 直播
    LiveListTypeGuide,      // 预告
};

@interface LiveRoomViewController : BaseViewController

@end
