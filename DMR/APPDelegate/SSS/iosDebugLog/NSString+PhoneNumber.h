//
//  NSString+PhoneNumber.h
//  happigo
//
//  Created by klx on 15/3/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PhoneNumber)

- (BOOL)hasBlank;

- (BOOL)isPureInt:(NSString*)string;

- (BOOL)isMobileNumber:(NSString *)mobileNum;

- (NSString *)getMD5BySourceString:(NSString *)str;

+ (NSDictionary *)signWithSourceParameters:(NSDictionary *)parameters;

+ (NSString *)jsonStringWithString:(NSString *)string;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)jsonStringWithObject:(id)object;

- (NSDictionary *)getMainDic;

- (NSDictionary *)getVideoEnterRoomDic;

- (NSDictionary *)getVideoCommentDic;
- (NSDictionary *)getVideoStar;

@end
