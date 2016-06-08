//
//  NSString+Size.m
//  happigo
//
//  Created by shklxmac111 on 15/12/29.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "NSString+Size.h"
#import <CoreText/CoreText.h>

@implementation NSString (Size)

-(CGSize)SizeWithFont:(UIFont *)font Size:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize StringSize = [self
                   boundingRectWithSize:size
                   options:NSStringDrawingUsesFontLeading|
                   NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:font,
                                NSParagraphStyleAttributeName:paragraphStyle}
                   context:nil].size;
    
    return StringSize;
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

-(CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size {
    CGSize stringSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesFontLeading|
                                                   NSStringDrawingUsesLineFragmentOrigin|
                                                   NSStringDrawingTruncatesLastVisibleLine
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil].size;
    return stringSize;
}

-(CGSize)sizeWithDefaultLineSpaseOfFont:(UIFont *)font Size:(CGSize)size {
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    if (IOS_SYSTEM < 9.0) {
        [paragraphStyle1 setLineSpacing:4];
        [paragraphStyle1 setParagraphSpacing:2];
    }
    else
    {
        [paragraphStyle1 setLineSpacing:0.1];
        [paragraphStyle1 setParagraphSpacing:2];
    }
    CGSize stringSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesFontLeading|
                         NSStringDrawingUsesLineFragmentOrigin|
                         NSStringDrawingTruncatesLastVisibleLine
                                        attributes:@{NSFontAttributeName : font,
                                                     NSParagraphStyleAttributeName : paragraphStyle1
                                                     }
                                           context:nil].size;
    return stringSize;
}

-(CGSize)SizeShareWithFont:(UIFont *)font Size:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    if (IOS_SYSTEM < 9.0) {
        [paragraphStyle setLineSpacing:4];
    }
    else
    {
        [paragraphStyle setLineSpacing:0.1];
    }
    
    
    CGSize StringSize = [self
                         boundingRectWithSize:size
                         options:NSStringDrawingUsesFontLeading|
                         NSStringDrawingUsesLineFragmentOrigin|
                         NSStringDrawingTruncatesLastVisibleLine
                         attributes:@{NSFontAttributeName:font,
                                      NSParagraphStyleAttributeName:paragraphStyle}
                         context:nil].size;
    return StringSize;
}




@end
