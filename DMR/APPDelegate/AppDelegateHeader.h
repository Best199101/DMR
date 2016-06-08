//
//  AppDelegateHeader.h
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#ifndef AppDelegateHeader_h
#define AppDelegateHeader_h

#import "WXApi.h"
//#import "JSONKit.h"
#import "UMSocial.h"
//#import "OpenUDID.h"
#import <AdSupport/AdSupport.h>
#import "WeiboSDK.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "LiPushHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "WelcomeViewController.h"
#import "LiThirdPartyAuthorizationOBJ.h"

#import "MobClick.h"
//#import "BaiduMobStat.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "DebugLog.h"
#import "SynchronizeManager.h"
//#import "LiShareObJ.h"
#import "EMSDK.h"
#import "AppDelegate+EaseMob.h"
#import "DMRChatManager.h"
//#import "Pingpp.h"

#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define KTestGeTuiAppID @"zi5zWTHS5Q8ir8lzt7B4Z1"
#define KTestGeTuiAppKey @"CFHC3gcIzR6opqGvZMqGI2"
#define KTestGeTuiAppSecret @"NXbY6BvQ7n5jlOHhqSOFK5"

#define KGeTuiAppID         @"WR7fnjZCvg6neOWoLXdeM6"
#define KGeTuiAppkey        @"Lu7Mdc2ECk7FTNTnD6q2K5"
#define KGeTuiAppSecret     @"V5Ae8t8WbL9S8KCQ0Y95y9"

//趣看界面适配，判断机型。
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width

#endif 
