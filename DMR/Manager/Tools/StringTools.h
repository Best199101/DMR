//
//  StringTools.h
//  xiaoqu
//
//  Created by wendy on 15/9/7.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringTools : NSObject

// 64 编码
+ (NSString *)base64EncodeString:(NSString *)string;
// 64 解码
+ (NSString *)base64DecodeString:(NSString *)string;
// 大数转换样式
+ (NSString *)number:(float)num;

//转URL
+ (NSString *)convertURL:(NSString *)url;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)liveNumber:(float)num;

@end
