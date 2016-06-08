//
//  NSString+Size.h
//  happigo
//
//  Created by shklxmac111 on 15/12/29.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
/**
 *  字符串size计算
 *
 *  @param font 字体
 *  @param size 约束Size
 *
 *  @return size
 */

-(CGSize)SizeWithFont:(UIFont *)font Size:(CGSize)size;

/**
 *  字符串size计算
 *
 *  @param font 字体
 *  @param size 约束Size
 *  @param lineSpace 行间距
 *  @param fontSpace 字间距
 *
 *  @return size
 */

-(CGSize)SizeWithFont:(UIFont *)font
                 Size:(CGSize)size
        withLineSpace:(CGFloat)lineSpace
         andFontSpace:(CGFloat)fontSpace;

-(CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size;
-(CGSize)sizeWithDefaultLineSpaseOfFont:(UIFont *)font Size:(CGSize)size;

-(CGSize)SizeShareWithFont:(UIFont *)font Size:(CGSize)size;


@end
