//
//  LiAFNetWorkingTool.h
//  happigo
//
//  Created by klx on 15/3/13.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"

@interface LiAFNetWorkingTool : NSObject

+ (void)GET:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id responseObject))success  failure:(void (^)(NSString *error))failure;
+ (void)POST:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id responseObject))success  failure:(void (^)(NSString *error))failure;
+(void)GETS:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSString *))failure;




@end
