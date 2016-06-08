//
//  ConcernAndBlackListModel.h
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ConcernAndBlackListModel : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSArray *blacklist;
@property (strong,nonatomic) NSArray *concernlist;
@property (strong,nonatomic) NSNumber *createtime;

@end

@interface ConcernAndBlackModel : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSNumber *level;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSString *headurl;
@property (strong,nonatomic) NSString *currentuid;
@property (strong,nonatomic) NSNumber *ismaster;

@end
