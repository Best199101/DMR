//
//  GeTuiManager.m
//  DMR
//
//  Created by shklxmac111 on 15/12/14.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "GeTuiManager.h"
#import "SDKKey.h"

@implementation GeTuiManager

/**
 *  初始化个推
 */
-(void)initGetuiSDK
{
    [GeTuiSdk startSdkWithAppId:GeTuiAPPID
                         appKey:GeTuiAPPKey
                      appSecret:GeTuiAppSecret
                       delegate:self];
}

#pragma mark - 个推代理
/**
 *  SDK启动成功返回cid
 *
 *  @return
 */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/**
 *  SDK遇到错误回调
 *
 *  @return
 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/**
 *  SDK收到透传消息回调
 *
 *  @return
 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId
                        andTaskId:(NSString *)taskId
                     andMessageId:(NSString *)aMsgId
                       andOffLine:(BOOL)offLine
                  fromApplication:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    /**
     *汇报个推自定义事件
     *actionId：用户自定义的actionid，int类型，取值90001-90999。
     *taskId：下发任务的任务ID。
     *msgId： 下发任务的消息ID。
     *返回值：BOOL，YES表示该命令已经提交，NO表示该命令未提交成功。注：该结果不代表服务器收到该条命令
     **/
    [GeTuiSdk sendFeedbackMessage:90001
                           taskId:taskId
                            msgId:aMsgId];
}

/**
 *  SDK收到sendMessage消息回调
 *
 *  @return
 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    NSLog(@"\n>>>[GexinSdk DidSendMessage]:%@\n\n",msg);
}

/**
 *  SDK运行状态通知
 *
 *  @return
 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    NSLog(@"\n>>>[GexinSdk SdkState]:%u\n\n",aStatus);
}

/**
 *  SDK设置推送模式回调
 *
 *  @return
 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>>[GexinSdk SetModeOff Error]:%@\n\n",[error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>>[GexinSdk SetModeOff]:%@\n\n",isModeOff?@"开启":@"关闭");
}


@end
