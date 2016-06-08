//
//  StringTools.m
//  xiaoqu
//
//  Created by wendy on 15/9/7.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import "StringTools.h"

@implementation StringTools

+ (NSString *)base64EncodeString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSString *)base64DecodeString:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)convertURL:(NSString *)url;
{
    NSString *url2;
    if ([[url.lowercaseString substringToIndex:7] isEqualToString:@"http://"]) {
        url2 = [NSString stringWithFormat:@"http://%@",[url substringFromIndex:7]];
    }else if ([[url.lowercaseString substringToIndex:8] isEqualToString:@"https://"]) {
        url2 = [NSString stringWithFormat:@"https://%@",[url substringFromIndex:8]];
    }else if ([[url.lowercaseString substringToIndex:6] isEqualToString:@"ftp://"]) {
        url2 = [NSString stringWithFormat:@"ftp://%@",[url substringFromIndex:6]];
    }else {
        url2 = [NSString stringWithFormat:@"http://%@",url];
    }
    
    return url2;
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSString *)number:(float)num
{
//    if (num>=1000 && num < 10000) {
//        float remainder = num/1000;
//        NSString *str = [NSString stringWithFormat:@"%.1fK",remainder];
//        NSString *str1 = [NSString stringWithFormat:@"%@K", [str substringWithRange:NSMakeRange(0, str.length - 3)]];
//        NSString *str2 = [str substringWithRange:NSMakeRange(str.length - 2, 1)];
//        //
//        if ([str2 isEqualToString:@"0"]) {
//            str = str1;
//        }
//        
//        return str;
//    }else
    if(num >= 10000)
    {
        float remainder = num/10000;
        NSString *str = [NSString stringWithFormat:@"%.1fW",remainder];
        NSString *str1 = [NSString stringWithFormat:@"%@W", [str substringWithRange:NSMakeRange(0, str.length - 3)]];
        NSString *str2 = [str substringWithRange:NSMakeRange(str.length - 2, 1)];
        
        if ([str2 isEqualToString:@"0"]) {
            str = str1;
        }
        return str;
        
    }
    else
    {
        NSString *str2 = [NSString stringWithFormat:@"%ld",(NSInteger)num];
        return str2;
    }
}

#pragma mark - 直播数字以W形式显示
+ (NSString *)liveNumber:(float)num{
    
    if (num>=1000 && num < 10000) {
        float remainder = num/1000;
        NSString *str = [NSString stringWithFormat:@"%.1fK",remainder];
        NSString *str1 = [NSString stringWithFormat:@"%@K", [str substringWithRange:NSMakeRange(0, str.length - 3)]];
        NSString *str2 = [str substringWithRange:NSMakeRange(str.length - 2, 1)];
        if ([str2 isEqualToString:@"0"]) {
            str = str1;
        }

        return str;
    }else if(num >= 10000){
        float remainder = num/10000;
        NSString *str = [NSString stringWithFormat:@"%.1fW",remainder];
        NSString *str1 = [NSString stringWithFormat:@"%@W", [str substringWithRange:NSMakeRange(0, str.length - 3)]];
        NSString *str2 = [str substringWithRange:NSMakeRange(str.length - 2, 1)];

        if ([str2 isEqualToString:@"0"]) {
            str = str1;
        }

        return str;

    } else if(num > 0 && num < 1000){
        NSString *str2 = [NSString stringWithFormat:@"%d",(NSInteger)num];
        return str2;
    } else{
        return @"0";
    }
}


@end
