//
//  LiPushHandler.m
//  happigo
//
//  Created by Coir on 15/6/3.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "LiPushHandler.h"
#import "NSString+PhoneNumber.h"
//#import "MyBroadcastDetailVC.h"

@interface LiPushHandler ()  {
    NSString *contentStr;
}

@end

@implementation LiPushHandler

+ (void)handlePushMessage:(NSString *)message   {
    LOG(@"Enter The Founction");
    NSLog(@" ==  %@",message);
    NSDictionary *dic = [message getMainDic];
    if ([dic[@"msgType"] intValue] == 1) {
        if ([dic[@"data"][@"funcType"] intValue] == 3) {
            NSLog(@"message  8888  %@",message);
             //[MainTabBar.pushHandler handleMessageByPushType:5 AndContentStr:dic[@"data"][@"content"]];
            return;
        }
    }
    
    NSNumber *msgType = dic[@"data"][@"funcType"];

    NSString *contentStr = dic[@"data"][@"content"];
    [MainTabBar.pushHandler handleMessageByPushType:msgType.intValue
                                      AndContentStr:contentStr];
    LOG(@"Leave The Founction");
    
}

- (void)handleMessageByPushType:(pushType)pushType AndContentStr:(NSString *)content  {
    contentStr = content;
    switch (pushType) {
        case pushTypeVideoShit:
        case pushTypeVideoFlower:
            break;
        case pushTypeVideoEnterRoom:
            [self handleVideoEnterRoomPush];
            break;
        case pushTypeMyBroadcast:
            [self handleMyBroadcastPush];
            break;
        case pushTypeVideoApplicationNotice:{
            [self handleVideoApplicationPush];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预约提示" message:content delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        case pushTypeMyFootPrint:
            [self handleMyFootPrintPush];
            break;
        case pushTypeVideoComment:
            [self handleVideoCommentPush];
            break;
        case pushTypeVideoStar:
            [self handleVideoStarPush];
            break;
            
        default:
            break;
    }
}

- (void)handleVideoEnterRoomPush    {
    NSDictionary *dic = [contentStr getVideoEnterRoomDic];
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleNewNoticePush)])
    {
    [self.delegate handleVideoPush:dic];
    };
}

- (void)handleVideoCommentPush    {
    NSDictionary *dic = [contentStr getVideoCommentDic];
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleNewNoticePush)])
    {
    [self.delegate handleVideoPush:dic];
    };
}

- (void)handleMyFootPrintPush    {
    [UserDefault setBool:YES forKey:@"HasNewFootPrint"];
    [UserDefault setBool:YES forKey:@"HasNewNotice"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleNewNoticePush)])
    {
        [self.delegate handleNewNoticePush];
    }
}

- (void)handleMyBroadcastPush    {
    [UserDefault setBool:YES forKey:@"HasNewBroadcast"];
    [UserDefault setBool:YES forKey:@"HasNewNotice"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleNewNoticePush)])
    {
        [self.delegate handleNewNoticePush];
    }
}

- (void)handleVideoApplicationPush    {
}
-(void)handleVideoStarPush
{
    NSDictionary *dic = [contentStr getVideoStar];
    [self.delegate handleVideoPush:dic];
}


@end
