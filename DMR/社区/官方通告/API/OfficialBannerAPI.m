//

//  OfficialBannerAPI.m

//  happigo

//

//  Created by shklxmac111 on 16/1/11.

//  Copyright (c) 2016年 klx.iOS. All rights reserved.

//



#import "OfficialBannerAPI.h"



#define OfficialBanner @"new/cy/offical/banners.do?channelcode="



@implementation OfficialBannerAPI



-(NSString *)APIHTTPMethod

{
    
    return GETHTTPMethod;
    
}



-(NSString *)APIReqeustURL

{
    
    return OfficialBanner;
    
}

-(void)startRequest

{
    
    [self startRequestUsingPara:nil];
    
}



@end

