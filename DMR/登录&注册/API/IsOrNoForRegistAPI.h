//
//  IsOrNoForRegistAPI.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface IsOrNoForRegistAPI : BaseAPIManager

/**
 *
 *  account     用户账号名(手机号码)
 */
- (void)startRequestWithAccount:(NSString *)account;

@end
