//
//  NSString+PhoneNumber.m
//  happigo
//
//  Created by klx on 15/3/31.
//  Copyright (c) 2015年 klx.iOS. All rights reserved.
//

#import "NSString+PhoneNumber.h"
#import "NSArray+Order.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>


@implementation NSString (PhoneNumber)

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)hasBlank   {
    NSRange _range = [self rangeOfString:@" "];
    if (_range.location != NSNotFound)  return YES;
    else                                return NO;
}

+ (NSDictionary *)signWithSourceParameters:(NSDictionary *)parameters  {
    NSMutableDictionary *dic;
    if (parameters == nil) {
        dic = [NSMutableDictionary new];
    }else{
        dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    [dic setObject:[UIDevice currentDevice].identifierForVendor.UUIDString forKey:@"deviceId"];
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionId"];
    [dic setObject:@((long long)([[NSDate date] timeIntervalSince1970] * 1000)) forKey:@"reqTime"];
    if (parameters != nil) {
        if (MainTabBar.currentUser.uid.length > 0)
        {
            [dic setObject:MainTabBar.currentUser.uid forKey:@"operatorUid"];
        }
    }
    [dic setObject:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
            forKey:@"idfa"];
    [dic setObject:[UIDevice currentDevice].model forKey:@"mobileType"];

    if (isTestEnvironment)  [dic setObject:KTestAppIDForSign forKey:@"appid"];
    else                    [dic setObject:KAppIDForSign forKey:@"appid"];
    NSString *str = [NSString jsonStringWithDictionary:dic];
    NSString *md5 = [str getMD5BySourceString:str];
    [dic setObject:md5 forKey:@"sign"];
    return dic;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    NSArray* arr = [dictionary allKeys];
    arr = [arr getOrderedArray];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [arr objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [valueObj isKindOfClass:[NSNumber class]] ? valueObj : [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"%@=%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@"&"]];
    [reString appendString:@"&"];

    if (isTestEnvironment)  [reString appendString:KTestAppSecretForSign];
    else                    [reString appendString:KAppSecretForSign];
    return reString;
}

- (NSString *)getMD5BySourceString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
//        [TNToast showWithText:@"请输入正确的手机号"];
        return NO;
    }
}

+ (NSString *)jsonStringWithString:(NSString *)string{
    return [NSString stringWithFormat:@"%@", [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\" "withString:@"\\\""]
            ];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}


+ (NSString *)jsonStringWithObject:(id)object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

- (NSDictionary *)getMainDic    {
    NSData *data = [self dataUsingEncoding:4];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}

- (NSDictionary *)getVideoEnterRoomDic  {
    NSArray *values = [self componentsSeparatedByString:@"||"];
    NSArray *keys = @[@"content", @"watchNum", @"videoId",@"uid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//<<<<<<< HEAD
//    for (int i = 0; i < keys.count ; i++)  [dic setObject:values[i] forKey:keys[i]];
//    [dic setValue:@"6" forKey:@"type"];
//=======
    
#warning 因为此处一直崩溃，暂时避免下 ------ 李海龙
    //数组问题，这个地方的情况如何避免
    if (values.count > keys.count) {
        NSMutableArray *temValues = [NSMutableArray arrayWithArray:values];
        NSMutableArray *temKeys = [NSMutableArray arrayWithArray:keys] ;
        [temValues removeLastObject];
        values = temValues ;
        keys = temKeys ;
    }
    for (int i = 0; i < values.count; i++)  [dic setObject:values[i] forKey:keys[i]];
    [dic setValue:@"6" forKey:@"type"];
//>>>>>>> shop
    return dic;
}

- (NSDictionary *)getVideoCommentDic  {
    NSArray *values = [self componentsSeparatedByString:@"||"];
    NSArray *keys = @[@"content", @"location", @"commentId", @"videoId", @"uid", @"nickName", @"head_img_url"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i <  keys.count ; i++)
    {
        [dic setObject:values[i] forKey:keys[i]];
    }
    [dic setValue:@"3" forKey:@"type"];
    return dic;
}

-(NSDictionary *)getVideoStar
{
    
    NSArray *values = [self componentsSeparatedByString:@","];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *keys   = @[@"starNumber",@"starSumNumber",@"videoId"];
    for (int i = 0; i < keys.count; i++)  [dic setObject:values[i] forKey:keys[i]];
    [dic setValue:@"8" forKey:@"type"];
    return dic;
}



@end



