//
//  AtUserListAPI.h
//  happigo
//
//  Created by shklxmac111 on 16/1/2.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface AtUserListAPI : BaseAPIManager <APIRequestProtocol>

-(void)startRequest;

@end
