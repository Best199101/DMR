//
//  LoginByThirdBindAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface LoginByThirdBindAPI : BaseAPIManager

/**
 *  authUid         第三方授权uid
 *  authToken       第三方授权accessToken
 *  authId          第三方授权平台id
 *  deviceId        设备id
 *  regSource       注册来源
 *  clientid        个推的clientid
 *
 */
- (void)startRequestWithAuthUid:(NSString *)authUid
                      authToken:(NSString *)authToken
                         authId:(NSString *)authId
                       deviceId:(NSString *)deviceId
                      regSource:(NSString *)regSource
                       clientid:(NSString *)clientid;

@end
