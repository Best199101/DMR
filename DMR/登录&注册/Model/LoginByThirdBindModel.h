//
//  LoginByThirdBindModel.h
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LoginByThirdBindModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSDictionary *userInfo;

@end
