//
//  TweetListAPI.h
//  DMR
//
//  Created by shklxmac111 on 15/12/22.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"


@interface TweetListChoiceAPI : BaseAPIManager<APIRequestProtocol>

@property (strong,nonatomic) NSNumber *lastTime;

-(void)startRequest;

@end
