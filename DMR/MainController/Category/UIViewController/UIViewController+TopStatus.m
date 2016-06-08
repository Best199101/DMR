//
//  UIViewController+TopStatus.m
//  xiaoqu
//
//  Created by wendy on 15/6/15.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import "UIViewController+TopStatus.h"
#import "TopStatusView.h"


@implementation UIViewController (TopStatus)

- (void)showStatusOnTop:(NSString *)text Status:(TopStatusType)type
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    TopStatusView *topStatusView = (TopStatusView *)[view viewWithTag:StatusViewTag];
    if (topStatusView == nil)
    {
        topStatusView = [[TopStatusView alloc]initWithViewController:self];
        [view addSubview:topStatusView];
    }
    [topStatusView showOnSuperView];
    topStatusView.statusMessage = text;
    if (type == sendingStatus)
    {
        topStatusView.backgroundColor = [UIColor redColor];
    }
    else if (type == successOnTopStatus)
    {
        topStatusView.backgroundColor = [UIColor redColor];
        [topStatusView hide:YES afterDelay:3];
    }
    else if (type == failedOnTopStatus)
    {
        topStatusView.backgroundColor = [UIColor redColor];
        [topStatusView hide:YES afterDelay:3];
    }
    else if (type == checkOnTopStatus)
    {
        topStatusView.backgroundColor = [UIColor redColor];
        [topStatusView hide:YES afterDelay:3];
    }
}



@end
