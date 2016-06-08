//
//  PraiseUserModel.h
//  happigo
//
//  Created by shklxmac111 on 15/12/30.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PraiseUserModel : MTLModel<MTLJSONSerializing>

@property (strong,nonatomic) NSString *headurl;
@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSNumber *ismaster;

@end
