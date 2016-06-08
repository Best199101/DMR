//
//  UIImage+Scale.h
//  xiaoqu
//
//  Created by shenhai on 15/4/17.
//  Copyright (c) 2015年 shenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (NSData *)dataScaleToSizeDataLength:(float)length;
- (UIImage *)scaleToSizeDataLength:(float)length; // 不推荐
- (UIImage *)scaleImagetoSize:(CGSize)size;
-(UIImage*)scaleToSomeSize:(CGSize)size;

/**
 *  按照比例系数缩放
 *
 *  @param factor 比例系数
 *
 *  @return 压缩之后的图片
 */
-(UIImage*)scaleWithFactor:(CGFloat)factor;


@end
