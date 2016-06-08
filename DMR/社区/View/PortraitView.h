//
//  PortraitView.h
//  DMR
//
//  Created by shklxmac111 on 15/12/10.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

extern NSString *const PortraitTap;

@interface PortraitView : BaseView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *tagView;

/**
 *  设置头像
 *
 *  @param userInfo @{
                      @"url":url,                 // 头像url
                      @"userId":userId            // 用户Id
                      @"location":location        // 保留字段
                     }
 */
-(void)setContentWithUserInfo:(NSDictionary *)userInfo;


@end
