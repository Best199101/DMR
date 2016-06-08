//
//  NSString+isNilOrEmpty.m
//  HealthBracelets
//
//  Created by JacobMao on 14-8-6.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "NSString+isNilOrEmpty.h"

@implementation NSString (isNilOrEmpty)



+ (BOOL)isNilOrEmpty:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    NSString *tmpString = [NSString stringWithFormat:@"%@", string];
    return [tmpString isEqualToString:@"(null)"] || [tmpString isEqualToString:@"<null>"];
}

+ (NSString *)emptyString{
    return @"";
}

- (BOOL)isContainSubString:(NSString *)string
{
    if ([self rangeOfString:string].location == NSNotFound) {
        return NO;
    }else
    {
        return YES;
    }
}

//NSString *string = @"hello bla bla";
//if ([string rangeOfString:@"bla"].location == NSNotFound) {
//    NSLog(@"string does not contain bla");
//} else {
//    NSLog(@"string contains bla!");
//}

/*
+ (NSString *)formatterDate:(NSDate*)date
{
    if (!date) {
        return nil;
    }
    
    NSInteger deltaDay = [NSDate deltaDayInteger:[NSDate date] withAnother:date];
    if (deltaDay == 0) {
        return @"今天";
    }
    if (deltaDay == 1) {
        return @"昨天";
    }
    if (deltaDay == 2) {
        return @"前天";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}

+ (NSArray *)showTotalTimeUsingHourMin:(double)timeInterval
{
    double doubleTimeInterval = timeInterval;
    int hour = (int)(doubleTimeInterval / 60);
    double hourMin = 60.0;
    float min = modf(doubleTimeInterval, &hourMin);
    return @[[NSString stringWithFormat:@"%d",hour],[NSString stringWithFormat:@"%d",(int)min]];
}

+ (NSString*)formatterHourMin:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    NSDateFormatter* HHmm = [[NSDateFormatter alloc] init];
    HHmm.timeStyle = NSDateFormatterNoStyle;
    HHmm.dateFormat = @"HH:mm";
    NSString* dateStr = [HHmm stringFromDate:date];
    return dateStr;
}

+ (NSString*)formatterDate:(NSDate *)date WithDateFormat:(NSString*)formatterStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateFormat = formatterStr;
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}

+ (NSString *)getFileNameWithDate:(NSDate *)date forKey:(NSString*)key
{
    NSString* userName = [[NSUserDefaults standardUserDefaults] stringForKey:UserName];
    NSString* fileName = [NSString stringWithFormat:@"%lu%lu%lu%@",(unsigned long)[NSDate getCurrentYear:date],(unsigned long)[NSDate getCurrentMonth:date],(unsigned long)[NSDate getCurrentDay:date],userName];
    if (![NSString isNilOrEmpty:key]) {
        fileName = [fileName stringByAppendingString:key];
    }
    return fileName;
}

+ (NSString*)FormatterDateYearMonthDay:(NSDate*)date
{
    if (!date) {
        return nil;
    }
    NSUInteger year = [NSDate getCurrentYear:date];
    NSUInteger month = [NSDate getCurrentMonth:date];
    NSUInteger day = [NSDate getCurrentDay:date];
    NSString* titleText = [NSString stringWithFormat:@"%lu年%lu月%lu日",(unsigned long)year,(unsigned long)month,(unsigned long)day];
    return titleText;
}

+ (NSString *)FormatterDateStr:(NSString *)dateStr WithStringFormat:(NSString *)formatterStr WithDateFormatter:(NSString *)dateFormatter
{
    NSDate* date = [NSDate getDateFromString:dateStr witFormatterStr:formatterStr];
    NSString* dateformatterStr = [self formatterDate:date WithDateFormat:dateFormatter];
    return dateformatterStr;
}
*/
@end
