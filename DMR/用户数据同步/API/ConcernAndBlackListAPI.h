//
//  ConcernAndBlackListAPI.h
//  happigo
//
//  Created by shklxmac111 on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface ConcernAndBlackListAPI : BaseAPIManager <APIRequestProtocol>

-(void)startRequestWithUid:(NSString *)uid
                CreateTime:(NSNumber *)createTime;

@end
