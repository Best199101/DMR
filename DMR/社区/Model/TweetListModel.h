//
//  TweetListModel.h
//  DMR
//
//  Created by shklxmac111 on 15/12/23.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface TweetList : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSArray *data;
@property (strong,nonatomic) NSNumber *lastTime;

@end

@interface TweetListModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSString *topicId;
@property (strong,nonatomic) NSNumber *isTop;
@property (strong,nonatomic) NSNumber *type;
@property (strong,nonatomic) NSNumber *ismaster;
@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSString *headurl;
@property (strong,nonatomic) NSNumber *level;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSNumber *createTime;
@property (strong,nonatomic) NSNumber *updateTime;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSNumber *commentCount;
@property (strong,nonatomic) NSNumber *praiseCount;
@property (strong,nonatomic) NSNumber *isPraise;
@property (strong,nonatomic) NSArray *tags;
@property (strong,nonatomic) NSArray *pics;
@property (strong,nonatomic) NSArray *commentList;
@property (strong,nonatomic) NSArray *headIcons;

@property (assign,nonatomic) CGFloat userInfoHeight;
@property (assign,nonatomic) CGFloat titleHeight;
@property (assign,nonatomic) CGFloat contentHeight;
@property (assign,nonatomic) CGFloat imagesHeight;
@property (assign,nonatomic) CGFloat tagHeight;
@property (assign,nonatomic) CGFloat commentHeight;
@property (assign,nonatomic) CGFloat userListHeight;

@property (assign,nonatomic) CGFloat totalHeight;

@property (assign,nonatomic) NSInteger attentionActionState; // 0 未操作，1 正在关注中

@end
