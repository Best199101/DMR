//
//  NSString+StringToValue.m
//  
//
//  Created by 雨 on 16/1/25.
//
//

#import "NSString+stringToValue.h"

@implementation NSString (StringToValue)

+ (NSString *)stringToValueWithJSONString:(NSString *)jsonString {
    if ( jsonString == nil ||
        [jsonString isEqual:[NSNull null]] ||
        [jsonString isEqualToString:@"(null)"] ||
        [jsonString isEqualToString:@"<null>"]
        )
    {
        return @"";
    }
    else
    {
        return jsonString;
    }
}

+ (NSString *)stringToValueOfDeletedEdgeSpaceWithJSONString:(NSString *)jsonString {
    if ([NSString isEmptyWithString:jsonString]) {
        return @"";
    }
    else
    {
        return [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
}

+ (NSString *)stringToValueOfDeletedSpaceWithJSONString:(NSString *)jsonString {
    if ([NSString isEmptyWithString:jsonString]) {
        return @"";
    }
    else
    {
        return [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

+ (BOOL)isEmptyWithString:(NSString *)string {
    if ([NSString stringToValueWithJSONString:string].length)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (NSAttributedString *)attributeStringWithString:(NSString *)string Font:(UIFont *)font LineSpace:(CGFloat)lineSpace CharacterSet:(NSCharacterSet *)characterSet{
    NSString *content;
    if ([NSString isEmptyWithString:string]) {
        content = @"";
    } else {
        content = [string stringByTrimmingCharactersInSet:characterSet];
    }
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = lineSpace;
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:content];
    [attribute addAttributes:@{NSFontAttributeName : font,
                               NSParagraphStyleAttributeName : paragraph
                               }
                       range:NSMakeRange(0, attribute.string.length)];
    return attribute;
}

+ (NSString *)stringToSourceStringWithString:(NSString *)string Width:(int)width Height:(int)height {
    if ([NSString isEmptyWithString:string]) {
        return @"";
    }
//    bmp|BMP|jpg|jpeg|JPEG|GIF|PNG|JPG|png|gif|webp服务端图片格式
    NSString *oldType = @"";
    NSString *newType = @"";
    if (width > 0 && height > 0) {
        if ([string rangeOfString:@".bmp" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".bmp";
            newType = [NSString stringWithFormat:@"_%d-%d.bmp",width,height];
        }
        else if ([string rangeOfString:@".BMP" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".BMP";
            newType = [NSString stringWithFormat:@"_%d-%d.BMP",width,height];
        }
        else if ([string rangeOfString:@".jpg" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".jpg";
            newType = [NSString stringWithFormat:@"_%d-%d.jpg",width,height];
        }
        else if ([string rangeOfString:@".JPG" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".JPG";
            newType = [NSString stringWithFormat:@"_%d-%d.JPG",width,height];
        }
        else if ([string rangeOfString:@".jpeg" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".jpeg";
            newType = [NSString stringWithFormat:@"_%d-%d.jpeg",width,height];
        }
        else if ([string rangeOfString:@".JPEG" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".JPEG";
            newType = [NSString stringWithFormat:@"_%d-%d.JPEG",width,height];
        }
        else if ([string rangeOfString:@".gif" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".gif";
            newType = [NSString stringWithFormat:@"_%d-%d.gif",width,height];
        }
        else if ([string rangeOfString:@".GIF" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".GIF";
            newType = [NSString stringWithFormat:@"_%d-%d.GIF",width,height];
        }
        else if ([string rangeOfString:@".png" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".png";
            newType = [NSString stringWithFormat:@"_%d-%d.png",width,height];
        }
        else if ([string rangeOfString:@".PNG" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".PNG";
            newType = [NSString stringWithFormat:@"_%d-%d.PNG",width,height];
        }
        else if ([string rangeOfString:@".webp" options:NSBackwardsSearch].location != NSNotFound)
        {
            oldType = @".webp";
            newType = [NSString stringWithFormat:@"_%d-%d.webp",width,height];
        }
    }
    NSString *newSourceString = [string stringByReplacingOccurrencesOfString:oldType withString:newType];
    return newSourceString;
}

@end
