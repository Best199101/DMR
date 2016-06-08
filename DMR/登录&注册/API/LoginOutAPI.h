//
//  LoginOutAPI.h
//  happigo
//
//  Created by 雨 on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface LoginOutAPI : BaseAPIManager

- (void)startRequestWithUid:(NSString *)uid;

@end
