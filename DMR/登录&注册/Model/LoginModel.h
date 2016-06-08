//
//  LoginModel.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>
@class BindMobileModel;
@class LoginUserInfoModel;

@interface LoginModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) BindMobileModel *bindMobile;
@property (nonatomic, strong) LoginUserInfoModel *userInfo;

@end

@interface BindMobileModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSNumber *international_no;
@property (nonatomic, strong) NSNumber *bind_mobile_no;

@end

