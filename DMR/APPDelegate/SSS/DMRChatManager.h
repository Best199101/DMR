//
//  DMRChatManager.h
//  happigo
//
//  Created by mac110 on 16/5/9.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMSDK.h"
#import "EaseUI.h"

@class ChatViewController;
@class ConversationListController;

@interface DMRChatManager : NSObject <EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate>

@property (nonatomic, weak) ChatViewController *chatController;

@property (nonatomic, weak) ConversationListController *conversationListVC;

@property (nonatomic, weak) UIBarButtonItem *msgListBtn;

- (void) playSoundAndVibration;

- (void) didReceiveLocalNotification: (UILocalNotification *)notification;

+ (instancetype) sharedManager;

- (void) loginWithUserName: (NSString *)userName password: (NSString *)password;

- (void)asyncPushOptions;

- (void)asyncConversationFromDB;

// 缓存对方环信id, 昵称和头像
- (EaseUserModel *) getUserModelWithConversationId: (NSString *)conversationId;

- (void) saveUserModelWithId: (NSString *)_id model: (EaseUserModel *)userModel;

- (void) cacheUserInfo;

- (EMError *) logOutAndUnbindDeviceToken;

- (void) chatWithEid: (NSString *)eid nickName: (NSString *)nickName;

- (void) ayncBindDeviceToken:(NSData *)token;

- (void) retryLoginChatServer;

@end


