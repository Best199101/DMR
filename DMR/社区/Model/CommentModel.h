//
//  CommentModel.h
//  happigo
//
//  Created by shklxmac111 on 15/12/28.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CommentList :MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSArray *data;

@end

@interface CommentModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSString *commendId;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSNumber *deleteFlag;
@property (strong,nonatomic) NSString *deviceId;
@property (strong,nonatomic) NSString *headUrl;
@property (strong,nonatomic) NSNumber *isPraise;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSString *parentId;
@property (strong,nonatomic) NSString *parentUid;
@property (strong,nonatomic) NSArray *pic;
@property (strong,nonatomic) NSNumber *praise;
@property (strong,nonatomic) NSString *topicId;
@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *updateTime;

@end
