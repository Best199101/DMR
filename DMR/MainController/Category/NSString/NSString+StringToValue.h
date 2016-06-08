//
//  NSString+StringToValue.h
//  
//
//  Created by 雨 on 16/1/25.
//
//

#import <Foundation/Foundation.h>

@interface NSString (StringToValue)

/*
 *  根据服务器给的JSON数据键--->>值，转成空字符串或原字符串
 *  若字符串是nil或null或(null)或<null>--->>转成空字符串
 *
 */
+ (NSString *)stringToValueWithJSONString:(NSString *)jsonString;

/*
 *  根据服务器给的JSON数据键--->>值，转成空字符串或原字符串
 *
 *  去除字符串两端空格--->>whitespaceCharacterSet
 */
+ (NSString *)stringToValueOfDeletedEdgeSpaceWithJSONString:(NSString *)jsonString;

/*
 *  根据服务器给的JSON数据键--->>值，转成空字符串或原字符串
 *
 *  去除字符串两端空格以及换行符产生的空白--->>whitespaceAndNewlineCharacterSet
 */
+ (NSString *)stringToValueOfDeletedSpaceWithJSONString:(NSString *)jsonString;

/*
 *  判断是否是空字符串
 *
 */
+ (BOOL)isEmptyWithString:(NSString *)string;

+ (NSAttributedString *)attributeStringWithString:(NSString *)string
                                             Font:(UIFont *)font
                                      LineSpace:(CGFloat)lineSpace
                                   CharacterSet:(NSCharacterSet *)characterSet;
/*
 *  用于图片压缩--->>字符串sourceString
 *  bmp|BMP|jpg|jpeg|JPEG|GIF|PNG|JPG|png|gif|webp服务端图片格式
 *
 */
+ (NSString *)stringToSourceStringWithString:(NSString *)string Width:(int)width Height:(int)height;

@end
