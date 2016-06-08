//
//  AdvertisementAPI.h
//  DMR
//
//  Created by 李海龙 on 15/12/22.
//  Copyright © 2015年 wangzitao. All rights reserved.
//

#import "BaseAPIManager.h"
#import "APIRequestProtocol.h"

@interface AdvertisementAPI : BaseAPIManager<APIRequestProtocol>

-(void)startRequestWithParameters:(NSDictionary *)parameters;

@end
