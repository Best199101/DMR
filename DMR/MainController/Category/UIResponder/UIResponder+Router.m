//
//  DMRTabBarController.h
//  DMR
//
//  Created by shklxmac111 on 15/12/4.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
