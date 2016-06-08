//
//  AppDelegate+IM.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+IM.h"
#import "AppDelegate+EaseMob.h"

@implementation AppDelegate (IM)

- (void)dmr_EaseMob:(id)application options:(NSDictionary *)launchOptions {
    NSString *apnsCertName = nil;
    NSString *appkey = nil;
#if isTestEnvironment
    apnsCertName = @"DMR";
    appkey = @"shklx1234#wsdmr";
#else
    apnsCertName = @"chatdemoui";
#endif
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:nil];
    
}

@end
