//
//  LiThirdPartyAuthorizationOBJ.h
//  happigo
//
//  Created by klx on 15/4/10.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface LiThirdPartyAuthorizationOBJ : NSObject

+ (void)GetWeiBoAuthorizationWithVC:(UIViewController *)vc;

+ (void)GetWXAuthorizationWithVC:(UIViewController *)vc;

+ (void)GetQQAuthorizationWithVC:(UIViewController *)vc;

+ (void)loginWithWeiBo:(WBBaseResponse *)response;

+ (void)loginWithWX:(NSString *)code;


@end
