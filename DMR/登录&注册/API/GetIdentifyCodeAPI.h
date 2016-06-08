//
//  GetIdentifyCodeAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface GetIdentifyCodeAPI : BaseAPIManager

/**
 *  mobile      手机号码
 *  source      业务类型
 *  deviceId    设备id
 *
 */
- (void)startRequestWithMobile:(NSString *)mobile
                        source:(int)source
               internationalNo:(NSString *)internationalNo;

@end
