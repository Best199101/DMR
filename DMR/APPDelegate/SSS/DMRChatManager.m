//
//  DMRChatManager.m
//  happigo
//
//  Created by mac110 on 16/5/9.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "DMRChatManager.h"
#import "ConversationListController.h"
#import "ChatViewController.h"
#import "UIBarButtonItem+Badge.h"

static NSString *const saveUserInfoKey = @"saveUserInfoKey";
static NSString *const saveUidKey = @"saveUidKey";

@interface DMRChatManager ()
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (nonatomic, strong) NSMutableDictionary *userInfos;
@property (nonatomic, strong) NSMutableDictionary *idDic;
@end

static const CGFloat kDefaultPlaySoundInterval = 3.0;

@implementation DMRChatManager
{
    dispatch_queue_t _taskQueue;
    NSString *_imid;
    NSString *_password;
}

static DMRChatManager *manager;

- (void)dealloc {
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DMRChatManager alloc] init];
    });
    return manager;
}

- (instancetype) init {
    if (self = [super init]) {
        [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
        NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] objectForKey:saveUserInfoKey];
        if (tempDic && [tempDic isKindOfClass:[NSDictionary class]]) {
            _userInfos = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        }
        tempDic = [UserDefault objectForKey:saveUidKey];
        if (tempDic && [tempDic isKindOfClass:[NSDictionary class]]) {
            _idDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        }
        [self checkAccount];
    }
    return self;
}

- (void) checkAccount {
    NSDictionary *loginDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if (self.idDic.count == 0 && loginDict.count == 0) {
        [UserDefault removeObjectForKey:CurrentUserKey];
    }
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
//                messageStr = NSLocalizedString(@"message.image", @"Image");
                messageStr = @"[图片]";
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
//                messageStr = NSLocalizedString(@"message.voice", @"Voice");
                messageStr = @"[语音]";
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", message.from, messageStr];
    }
    else{
//        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
        notification.alertBody = @"收到一条新消息";
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    NSDictionary *userInfo = @{
                               @"conversationId" : message.conversationId,
                               @"title" : message.ext[@"nickname"] ? : @""
                               };
    notification.userInfo = userInfo;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - EMClientDelegate
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState {
    if (self.chatController && [self.chatController respondsToSelector:@selector(changeBarTitleWithNetStatus:)]) {
        [self.chatController changeBarTitleWithNetStatus:aConnectionState];
    }
}

- (void)didLoginFromOtherDevice {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"quit" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[EMClient sharedClient] logout:NO];
    });
    
    if (_chatController || _conversationListVC) {
        [MainTabBar.navigationController popToRootViewControllerAnimated:NO];
    }
    [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"帐号在其他设备登录" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
    [self clean];
}

#pragma mark - EMChatManagerDelegate
- (void)didUpdateConversationList:(NSArray *)aConversationList {
    
}
- (void)didReceiveMessages:(NSArray *)aMessages {
    for(EMMessage *message in aMessages){
        BOOL needShowNotification = YES;
        if (needShowNotification) {
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            switch (state) {
                case UIApplicationStateActive:
                    if (self.conversationListVC || self.chatController) {
                        [self playSoundAndVibration];
                    }
                    break;
                case UIApplicationStateBackground:
                    [self showNotificationWithMessage:message];
                    break;
                default:
                    break;
            }
        }
        if (message.ext) {
            EaseUserModel *userItem = [EaseUserModel new];
            userItem.nickname = message.ext[@"nickname"];
            userItem.avatarURLPath = message.ext[@"headUrl"];
            [[DMRChatManager sharedManager] saveUserModelWithId:message.conversationId model: userItem];
        }
        [self.conversationListVC refreshDataSource];
        [self setupUnreadMessageCount];
    }
}

- (void)didMessageStatusChanged:(EMMessage *)aMessage error:(EMError *)aError {
}

#pragma mark - public

- (void)playSoundAndVibration {
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    
    // 保存登录信息，为重新登录环信作准备
    _imid = userName;
    _password = password;
    [self saveUserLoginInfo];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:@"iostest111" password:@"123456"];
        if (!error) {
            [self didLoginEaseMob];
        }
    });
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    NSString *conversationId = dic[@"conversationId"];
    NSString *nickName = dic[@"nickname"];
    if (self.chatController == nil) {
        [self startChatWithId:conversationId title:nickName];
    }
    else {
        if (![conversationId isEqualToString:self.chatController.conversation.conversationId]) {
            [MainTabBar.navigationController popViewControllerAnimated:NO];
            [self startChatWithId:conversationId title:nickName];
        }
    }
}

- (void) startChatWithId: (NSString *)conversationId title: (NSString *)title {
    ChatViewController *chatvc = [[ChatViewController alloc] initWithConversationChatter:conversationId conversationType:EMConversationTypeChat];
    chatvc.dataSource = (id<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>)chatvc;
    chatvc.delegate = (id<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>)chatvc;
    chatvc.title = title;
    [MainTabBar.navigationController pushViewController:chatvc animated:NO];
    self.chatController = chatvc;
}

- (void)updateBadgeUnreadCount:(NSInteger)unreadCount {
    if (unreadCount <= 0) {
        _msgListBtn.badgeValue = @"";
    }
    _msgListBtn.badgeValue  = [NSString stringWithFormat:@"%li", (long)unreadCount];
    _msgListBtn.badgeOriginX = _msgListBtn.customView.bounds.size.width;
}

- (void) reset {
    self.chatController = nil;
    self.conversationListVC = nil;
}

- (void)asyncPushOptions
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        [[EMClient sharedClient] getPushOptionsFromServerWithError:&error];
    });
}

- (void)asyncConversationFromDB
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
        [array enumerateObjectsUsingBlock:^(EMConversation *conversation, NSUInteger idx, BOOL *stop){
            if(conversation.latestMessage == nil){
                [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId deleteMessages:NO];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakself.conversationListVC) {
                [weakself.conversationListVC refreshDataSource];
            }
            [weakself setupUnreadMessageCount];
        });
    });
}

- (void)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    [self updateBadgeUnreadCount:unreadCount];
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (EaseUserModel *)getUserModelWithConversationId:(NSString *)conversationId {
    EaseUserModel *model = [EaseUserModel new];
    model.nickname = self.userInfos[conversationId][@"nickname"];
    model.avatarURLPath = self.userInfos[conversationId][@"headUrl"];
    return model;
}

- (void)saveUserModelWithId:(NSString *)_id model:(EaseUserModel *)userModel {
    self.userInfos[_id] = @{
                            @"nickname" : userModel.nickname,
                            @"headUrl" : userModel.avatarURLPath
                            };
}

- (void) saveEaseId: (NSString *)eid uid: (NSString *)uid {
    self.idDic[uid] = eid;
    [UserDefault setObject:_idDic forKey:saveUidKey];
}

- (void)cacheUserInfo {
    if (!_taskQueue) {
        _taskQueue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_async(_taskQueue, ^{
        [UserDefault setObject:self.userInfos forKey:saveUserInfoKey];
        [UserDefault synchronize];
    });
}

- (NSMutableDictionary *)userInfos {
    if (!_userInfos) {
        _userInfos = [NSMutableDictionary dictionary];
    }
    return _userInfos;
}

- (NSMutableDictionary *) idDic {
    if (!_idDic) {
        _idDic = [NSMutableDictionary dictionary];
    }
    return _idDic;
}

- (EMError *)logOutAndUnbindDeviceToken { // 主动退出调用，解绑deviceToken
    EMError *err = [[EMClient sharedClient] logout:YES];
    if (!err) {
        [self clean];
    }
    return err;
}

- (void)chatWithEid:(NSString *)eid nickName:(NSString *)nickName {
    if (eid == nil || eid.length == 0) {
        return;
    }
    if (self.idDic.count == 0) {
        [self retryLoginChatServer];
        return;
    }
    [self startChatWithId:eid title:nickName];
}

- (void) ayncBindDeviceToken:(NSData *)token {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:token];
    });
}

- (void) saveUserLoginInfo {
    [UserDefault setObject:@{@"name" : _imid, @"pwd" : _password} forKey:@"login"];
}

- (void)retryLoginChatServer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:_imid password:_password];
        if (!error) {
            [self didLoginEaseMob];
        }
    });
}

- (void) didLoginEaseMob {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        [[DMRChatManager sharedManager] asyncConversationFromDB];
        [[DMRChatManager sharedManager] asyncPushOptions];
        
        User *user = [User initWithDictionary:[UserDefault objectForKey:CurrentUserKey]];
        [self saveEaseId:@"eid" uid:user.uid];
    });
}

- (void) clean {
    [self.idDic removeAllObjects];
    [UserDefault removeObjectForKey:saveUidKey];
    [UserDefault removeObjectForKey:@"login"];
    [UserDefault removeObjectForKey:CurrentUserKey];
    _imid = _password = @"";
    [self reset];
}
@end
