//
//  RegistByMobileAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface RegistByMobileAPI : BaseAPIManager

/**
 *  mobile      用户账号名(手机号码)
 *  password    账号密码
 *  code        验证码
 *  regSource   注册来源
 *  deviceId    设备id
 *
 */
- (void)startRequestWithMobile:(NSString *)mobile
                      password:(NSString *)password
                          code:(NSString *)code
                     regSource:(int)regSource
                      deviceId:(NSString *)deviceId;

@end
