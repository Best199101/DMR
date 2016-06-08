//
//  PersonSignAPI.h
//  happigo
//
//  Created by fei on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface PersonSignAPI : BaseAPIManager<APIRequestProtocol>

-(void)startRequestWithUid:(NSString *)uid;


@end
