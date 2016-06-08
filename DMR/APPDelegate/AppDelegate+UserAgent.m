//
//  AppDelegate+UserAgent.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+UserAgent.h"

static NSString *userAgent = @"kdtunion_beautygirl";


@implementation AppDelegate (UserAgent)

- (void)dmr_UserAgent {
    // 添加有赞商城 ************ 代码入口
    
    NSString* secretAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@%@",secretAgent,userAgent,@"1.0.1"], @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    // 添加有赞商城 ************ 代码出口

}

@end
