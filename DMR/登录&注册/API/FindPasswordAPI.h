//
//  FindPasswordAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface FindPasswordAPI : BaseAPIManager

/**
 *  account         用户账号名(手机号码)
 *  password       需要重置的密码
 *  code          验证码
 *
 */
- (void)startRequestWithAccount:(NSString *)account
                       password:(NSString *)password
                           code:(NSString *)code;

@end
