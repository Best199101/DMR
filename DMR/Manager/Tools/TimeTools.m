//
//  TimeTools.m
//  happigo
//
//  Created by 李海龙 on 15/12/29.
//  Copyright © 2015年 klx.iOS. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools

+ (NSString *)getTimeStringByTimeInterval:(NSTimeInterval)timeInterval{
    NSString *timeStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeInterval differenceInterval = [[NSDate date] timeIntervalSinceDate:date];
    int minute = differenceInterval / 60;
    int hour = differenceInterval / 3600;
    int day = differenceInterval / 3600 / 24;
    if (minute < 0 ) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM-dd  HH:mm"];
        timeStr = [dateFormatter stringFromDate:date];
    }else if (minute < 60) {
        minute = minute == 0 ? 1 : minute ;
        timeStr = [NSString stringWithFormat:@"%d分钟前", minute];
    } else  if (hour < 24) {
        timeStr = [NSString stringWithFormat:@"%d小时前", hour];
    } else if (day < 2)  {
        timeStr = [NSString stringWithFormat:@"昨天"];
    } else if (day < 3)  {
        timeStr = [NSString stringWithFormat:@"前天"];
    }else  {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM-dd  HH:mm"];
        timeStr = [dateFormatter stringFromDate:date];
    }
    return timeStr;
}
@end
