//
//  PersonLevelAPI.h
//  happigo
//
//  Created by fei on 16/3/2.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface PersonLevelAPI : BaseAPIManager<APIRequestProtocol>

-(void)startRequestWithLevel:(int)level;

@end
