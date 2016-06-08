//
//  AppDelegate+Fabric.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+Fabric.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate (Fabric)

- (void)dmr_Fabric {
    [[Fabric sharedSDK] setDebug: YES];
    [Fabric with:@[CrashlyticsKit]];
    [Fabric with:@[[Crashlytics class]]];
}

@end
