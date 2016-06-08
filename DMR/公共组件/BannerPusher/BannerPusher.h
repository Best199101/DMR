//
//  BannerPusher.h
//  happigo
//
//  Created by shklxmac111 on 16/1/11.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BannerPusher : NSObject

+(UIViewController *)targetViewControllerWithTargetType:(NSNumber *)targetType
                               TargetInfo:(NSString *)targetInfo
                                 ShowType:(NSNumber *)showType;

@end
