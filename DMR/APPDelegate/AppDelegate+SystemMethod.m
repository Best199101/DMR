//
//  AppDelegate+SystemMethod.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+SystemMethod.h"

#import "AppDelegateHeader.h"

#import "AppDelegate+UserAgent.h"
#import "AppDelegate+RootWindow.h"
#import "AppDelegate+NavBar.h"
#import "AppDelegate+UM.h"
#import "AppDelegate+PushNoti.h"
#import "AppDelegate+UserDefaultData.h"
#import "AppDelegate+Fabric.h"
#import "AppDelegate+IM.h"

@implementation AppDelegate (SystemMethod)

- (void)DMR_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LOG(@"Enter the function");
    
    // 环信
    [self dmr_EaseMob:application options:launchOptions];
    [DMRChatManager sharedManager];
    
    // 添加有赞商城 ************ 代码入口
    [self dmr_UserAgent];
    // 添加有赞商城 ************ 代码出口
    
    //添加iosDebugLog系统
    [DebugLog setDebug:OnlyWriteErrorLogToFile];
    
    //Fabric
    [self dmr_Fabric];
    
    //navBar属性设置
    [self dmr_NavBarAttributes];
    
    //设置时区
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    
    //友盟配置
    [self dmr_UmShareAppKey];
    //友盟统计
    [self dmr_UmCount];
    
    //远程通知设置
    [self dmr_RemoteNotification];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    LOG(@"Leave the function");
    
    [self dmr_UserDefaultData];
}

@end
