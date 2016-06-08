//
//  PraiseTweetAPI.h
//  happigo
//
//  Created by shklxmac111 on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"
@class TweetListModel;

@interface PraiseTweetAPI : BaseAPIManager <APIRequestProtocol>

@property (strong,nonatomic) TweetListModel *model;
/**
 *  点赞帖子接口
 *
 *  @param uid           当前用户id
 *  @param targetTopicId 被点赞的帖子id
 *  @param targetUid     被点赞的帖子的发帖人id
 */
-(void)startRequestWithUid:(NSString *)uid
             TargetTopicId:(NSString *)targetTopicId
                 TargetUid:(NSString *)targetUid;

@end
