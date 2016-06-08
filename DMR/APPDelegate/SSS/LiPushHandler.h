//
//  LiPushHandler.h
//  happigo
//
//  Created by Coir on 15/6/3.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushHandlerDelegate <NSObject>

@optional
- (void)handleVideoPush:(NSDictionary *)dic;

- (void)handleNewNoticePush;

@end

typedef enum {
    pushTypeVideoFlower = 1,
    pushTypeVideoShit = 2,
    pushTypeVideoComment = 3,
    pushTypeMyFootPrint = 4,
    pushTypeMyBroadcast = 5,
    pushTypeVideoEnterRoom = 6,
    pushTypeVideoApplicationNotice = 7,
    pushTypeVideoStar              = 8
    
}pushType;

@interface LiPushHandler : NSObject

@property (nonatomic, weak) id <PushHandlerDelegate> delegate;

+ (void)handlePushMessage:(NSString *)message;

@end
