//
//  NSString+HeightOfString.m
//  
//
//  Created by 雨 on 16/1/25.
//
//

#import "NSString+HeightOfString.h"
#import "NSString+StringToValue.h"
#import <CoreText/CoreText.h>

@implementation NSString (HeightOfString)

#pragma mark - 私有方法

- (CGFloat)HeightOfNewString:(NSString *)string Font:(UIFont *)font MaxSize:(CGSize)size LineSpace:(CGFloat)lineSpace{
    if ([NSString isEmptyWithString:string]) {
        return 0;
    }
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = lineSpace;
    CGFloat height = [string boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading |
                      NSStringDrawingTruncatesLastVisibleLine
                                       attributes:@{NSFontAttributeName : font,NSParagraphStyleAttributeName : paragraph
                                                    }
                                          context:nil].size.height;
    return height + 1;
}

#pragma mark - 公有方法

- (CGFloat)heightWithFont:(UIFont *)font maxSize:(CGSize)size {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:[NSParagraphStyle defaultParagraphStyle].lineSpacing];
    return height;
}

- (CGFloat)heightWithFont:(UIFont *)font maxSize:(CGSize)size andLineSpace:(CGFloat)lineSpace {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:lineSpace];
    return height;
}

- (CGFloat)heightOfDeletedEdgeSpaceWithFont:(UIFont *)font maxSize:(CGSize)size {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueOfDeletedEdgeSpaceWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:[NSParagraphStyle defaultParagraphStyle].lineSpacing];
    return height;
}

- (CGFloat)heightOfDeletedEdgeSpaceWithFont:(UIFont *)font maxSize:(CGSize)size andLineSpace:(CGFloat)lineSpace {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueOfDeletedEdgeSpaceWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:lineSpace];
    return height;
}

- (CGFloat)heightOfDeletedSpaceWithFont:(UIFont *)font maxSize:(CGSize)size {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueOfDeletedSpaceWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:[NSParagraphStyle defaultParagraphStyle].lineSpacing];
    return height;
}

- (CGFloat)heightOfDeletedSpaceWithFont:(UIFont *)font maxSize:(CGSize)size andLineSpace:(CGFloat)lineSpace {
    CGFloat height = [self HeightOfNewString:[NSString stringToValueOfDeletedSpaceWithJSONString:self]
                                        Font:font
                                     MaxSize:size
                                   LineSpace:lineSpace];
    return height;
}

-(CGSize)SizeWithFont:(UIFont *)font Size:(CGSize)size withLineSpace:(CGFloat)lineSpace andFontSpace:(CGFloat)fontSpace {
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    //字间距
    long number = fontSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    
    CGSize StringSize = [self
                         boundingRectWithSize:size
                         options:NSStringDrawingUsesFontLeading|
                         NSStringDrawingUsesLineFragmentOrigin|
                         NSStringDrawingTruncatesLastVisibleLine
                         attributes:@{NSFontAttributeName:font,
                                      NSParagraphStyleAttributeName:paragraphStyle,
                                      (id)kCTKernAttributeName:(__bridge id)num}
                         context:nil].size;
    CFRelease(num);
    
    return StringSize;
}

@end
