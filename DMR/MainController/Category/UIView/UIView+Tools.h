//
//  UIView+Tools.h
//  DMR
//
//  Created by shklxmac111 on 15/12/11.
//  Copyright (c) 2015年 wangzitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tools)

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

- (UIImage *)convertViewToImage;
- (UIViewController *)foundCurrentViewController;

@end
