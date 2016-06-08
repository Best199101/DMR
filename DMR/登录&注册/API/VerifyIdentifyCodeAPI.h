//
//  VerifyIdentifyCodeAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface VerifyIdentifyCodeAPI : BaseAPIManager

/**
 *  mobile      手机号码
 *  source      业务类型
 *  code        验证码
 *  deviceId    设备id
 *
 */
- (void)startRequestWithMobile:(NSString *)mobile
                        source:(int)source
                          code:(NSString *)code
                      deviceId:(NSString *)deviceId;

@end
