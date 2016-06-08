//
//  UpdatePasswordAPI.h
//  happigo
//
//  Created by 雨 on 16/3/3.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "BaseAPIManager.h"

@interface UpdatePasswordAPI : BaseAPIManager

//account               账号
//passwordOld           旧密码
//password              新密码
//deviceId              设备ID

- (void)startReauestWithAccount:(NSString *)account passwordOld:(NSString *)passwordOld password:(NSString *)password deviceId:(NSString *)deviceId;

@end
