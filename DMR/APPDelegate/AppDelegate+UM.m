//
//  AppDelegate+UM.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+UM.h"
#import "UMSocialData.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"

#import "MobClick.h"

@implementation AppDelegate (UM)

- (void)dmr_UmShareAppKey {
    [UMSocialData setAppKey:@"550fd86ffd98c5b4950004ae"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1202441551" secret:@"1fb57ea042a802be19704360f774153e" RedirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    [UMSocialWechatHandler setWXAppId:@"wx382eaad790b61b88" appSecret:@"b98f065924e67a8944f09e913883d3c8" url:@"http://www.dameiren.com"];
    [UMSocialQQHandler setQQWithAppId:@"1104495107" appKey:@"ejj5aDDxJ6t6vjVP" url:@"http://www.dameiren.com"];
}

- (void)dmr_UmCount {
//    [MobClick startWithAppkey:@"550fd86ffd98c5b4950004ae" reportPolicy:(ReportPolicy)REALTIME channelId:nil];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//    NSLog(@"当前版本:%@",version);
//    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
//    [MobClick setAppVersion:version];
//    
//    //友盟自动更新
//    [MobClick checkUpdate];
}

@end
