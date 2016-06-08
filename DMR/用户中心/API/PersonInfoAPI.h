//
//  PersonInfoAPI.h
//  happigo
//
//  Created by fei on 16/2/22.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface PersonInfoAPI : BaseAPIManager<APIRequestProtocol>

-(void)startRequestWithUid:(NSString *)uid;

@end
