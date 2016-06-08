//
//  Global.h
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#ifndef DMR_Global_h
#define DMR_Global_h

#define WeakObject(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define ApplicationDelegate  ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define IOS_SYSTEM           ([[[UIDevice currentDevice] systemVersion] floatValue])

#define UserId @"1111"

#import <Masonry/Masonry.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorTools.h"
#import "BaseView.h"
#import "UIDefine.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Tools.h"
#import "Interface.h"

#import "Notification.h"


#endif
