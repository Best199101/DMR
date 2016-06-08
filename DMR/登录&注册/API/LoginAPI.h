//
//  LoginAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface LoginAPI : BaseAPIManager

/**
 *  account     用户账号名(手机号码)
 *  password    账号密码
 *  clientid    个推的clientId
 *
 */
- (void)startRequestWithAccount:(NSString *)account
                       password:(NSString *)password
                       clientid:(NSString *)clientid;

@end
