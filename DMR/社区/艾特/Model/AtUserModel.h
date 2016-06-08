//
//  AtUserModel.h
//  happigo
//
//  Created by shklxmac111 on 16/1/2.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AtUserList : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSArray *data;

@end

@interface AtUserModel : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSString *head_img_url;
@property (strong,nonatomic) NSNumber *ismaster;
@property (strong,nonatomic) NSString *desc;

@end
