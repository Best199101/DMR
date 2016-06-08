//
//  AppDelegate+UserDefaultData.m
//  happigo
//
//  Created by 雨 on 16/5/27.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AppDelegate+UserDefaultData.h"

@implementation AppDelegate (UserDefaultData)

- (void)dmr_UserDefaultData {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LivingGoods"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"ShowGoods" forKey:@"LivingGoods"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
