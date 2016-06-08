//
//  ThemeActivitiesAPI.h
//  happigo
//
//  Created by fei on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface ThemeActivitiesAPI : BaseAPIManager<APIRequestProtocol>

@property(nonatomic, assign) int page;

-(void)startRequestWithPageNum:(int)page;

@end
