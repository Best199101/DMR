//
//  CommonBannerAPI.h
//  happigo
//
//  Created by shklxmac111 on 15/12/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

/**
 *  社区首页公共信息
 */

@interface CommonBannerAPI : BaseAPIManager <APIRequestProtocol>

@property (strong,nonatomic) NSString *channelCode;

-(void)startRequest;

@end
