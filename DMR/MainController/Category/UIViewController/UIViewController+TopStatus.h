//
//  UIViewController+TopStatus.h
//  xiaoqu
//
//  Created by wendy on 15/6/15.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopStatusView.h"

typedef enum : NSUInteger {
    sendingStatus,      //发送中
    successOnTopStatus, //成功
    failedOnTopStatus,  //失败
    checkOnTopStatus,   //内容不完整
    receiveMessageTopStatus, //接受到消息
    receiveEmergencyMessageTopStatus, //接收到紧急消息
} TopStatusType;

@interface UIViewController (TopStatus)

/**
 *  状态提示
 *
 *  @param text  提示文字
 *  @param type  状态
 */
- (void)showStatusOnTop:(NSString *)text Status:(TopStatusType)type;


@end
