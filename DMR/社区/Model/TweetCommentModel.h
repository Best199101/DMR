//
//  TweetCommentModel.h
//  happigo
//
//  Created by fei on 15/12/24.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TweetCommentModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *str2;
@property (nonatomic, strong) NSString *str3;
@property (nonatomic, strong) NSString *str4;
@property (nonatomic, strong) NSString *str5;

//帖子详情页 ---评论
@property (strong,nonatomic) NSString *parentId;
@property (strong,nonatomic) NSNumber *updateTime;
@property (strong,nonatomic) NSNumber *isPraise;
@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *_id;
@property (strong,nonatomic) NSArray *pic;
@property (strong,nonatomic) NSString *topicId;
@property (strong,nonatomic) NSNumber *ismaster;
@property (strong,nonatomic) NSString *parentUid;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *headurl;
@property (strong,nonatomic) NSNumber *praise;
@property (strong,nonatomic) NSString *deviceId;
@property (strong,nonatomic) NSNumber *createTime;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSNumber *deleteFlag;
@property (strong,nonatomic) NSString *content;


@end
