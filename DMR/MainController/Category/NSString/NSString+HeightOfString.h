//
//  NSString+HeightOfString.h
//  
//
//  Created by 雨 on 16/1/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HeightOfString)

#warning 需导入"NSString+stringToValue.h"

/*
 *  若字符串是nil或null或(null)或<null>--->>转成空字符串
 *  计算高度
 *
 */
- (CGFloat)heightWithFont:(UIFont *)font
                  maxSize:(CGSize)size;
- (CGFloat)heightWithFont:(UIFont *)font
                  maxSize:(CGSize)size
             andLineSpace:(CGFloat)lineSpace;

/*
 *  去除字符串两端空格--->>whitespaceCharacterSet
 *
 */
- (CGFloat)heightOfDeletedEdgeSpaceWithFont:(UIFont *)font
                                    maxSize:(CGSize)size;
- (CGFloat)heightOfDeletedEdgeSpaceWithFont:(UIFont *)font
                                    maxSize:(CGSize)size
                               andLineSpace:(CGFloat)lineSpace;
/*
 *  去除字符串两端空格以及换行符产生的空白--->>whitespaceAndNewlineCharacterSet
 *
 */
- (CGFloat)heightOfDeletedSpaceWithFont:(UIFont *)font
                                maxSize:(CGSize)size;
- (CGFloat)heightOfDeletedSpaceWithFont:(UIFont *)font
                                maxSize:(CGSize)size
                           andLineSpace:(CGFloat)lineSpace;

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
@end
