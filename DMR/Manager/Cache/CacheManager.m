//
//  CacheManager.m
//  xiaoqu
//
//  Created by wendy on 14/12/3.
//  Copyright (c) 2014年 shenhai. All rights reserved.
//

#import "CacheManager.h"
#include <sys/xattr.h>
#import "StringTools.h"
#import "NSString+MD5.h"
#import <UIKit/UIKit.h>
static unsigned long long size = 0;

@implementation CacheManager

+ (void) resetCache
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSFileManager defaultManager] removeItemAtPath:[CacheManager cacheDirectory] error:nil];
    });
}

+(unsigned long long) AllCacheSize:(NSString*) CachePath
{
    size = 0;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* allCache = [fileManager contentsOfDirectoryAtPath:CachePath error:nil];
    for(NSString* FileName in allCache)
    {
        NSString* fullFilePath = [CachePath stringByAppendingPathComponent:FileName];
        BOOL isDir;
        if ([fileManager fileExistsAtPath:fullFilePath isDirectory:&isDir])
        {
            NSDictionary* fileAtrribute = [fileManager attributesOfItemAtPath:fullFilePath error:nil];
            size += fileAtrribute.fileSize;
        }
//        else
//        {
//            [self AllCacheSize:fullFilePath];
//        }
    }
    return size;
}

+(void)removeOutTimeCache:(NSTimeInterval) cacheTime
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSLog(@"cache directory : %@",[self cacheDirectory]);
    NSArray* allCache = [fileManager contentsOfDirectoryAtPath:self.cacheDirectory error:nil];
    for(NSString* FileName in allCache)
    {
        NSString* fullFilePath = [self.cacheDirectory stringByAppendingPathComponent:FileName];
//        BOOL isDir;
//        if (![fileManager fileExistsAtPath:fullFilePath isDirectory:&isDir])
        {
            NSDictionary* fileAtrribute = [fileManager attributesOfItemAtPath:fullFilePath error:nil];
            NSDate *modificationDate = [fileAtrribute objectForKey:NSFileModificationDate];
            if ([modificationDate timeIntervalSinceNow] > cacheTime)
            {
                [fileManager removeItemAtPath:fullFilePath error:nil];
            }
        }
//        else
//        {
//            [self removeOutTimeCache:cacheTime];
//        }
    }
}

+(NSString*)cacheDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"66Caches"];
    __block BOOL isDir = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDirectory isDirectory:&isDir])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectory
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
        NSString* iOSversion = [UIDevice currentDevice].systemName ;
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:cacheDirectory] iOSVersion:iOSversion];
    });

    return cacheDirectory;
}

+(NSString*)failedTaskCacheDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"66failedTaskCache"];
    __block BOOL isDir = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDirectory isDirectory:&isDir])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectory
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
        NSString* iOSversion = [UIDevice currentDevice].systemName;
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:cacheDirectory] iOSVersion:iOSversion];
    });
    return cacheDirectory;
}

+(void)saveCacheWithObject:(id)object ForURLKey:(NSString*)URLKey AndType:(CacheType)Cachetype
{
    __block NSString *filepath;
    NSString *filePathKey = [[StringTools base64EncodeString:URLKey] MD5Hash];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (Cachetype == CacheTypeFailedTask)
        {
            filepath = [self.failedTaskCacheDirectory stringByAppendingPathComponent:filePathKey];
        }
        else
        {
            filepath = [self.cacheDirectory stringByAppendingPathComponent:filePathKey];
        }
        @try
        {
            [NSKeyedArchiver archiveRootObject:object toFile:filepath];
        }
        @catch (NSException *exception)
        {
        }
        @finally
        {
            NSLog(@"end");
        }
    });
}

+(void)save_SyncCacheWithObject:(id)object ForURLKey:(NSString*)URLKey AndType:(CacheType)Cachetype
{
    
    NSString *filePathKey = [[StringTools base64EncodeString:URLKey] MD5Hash];
    NSString *filepath;
    if (Cachetype == CacheTypeFailedTask)
    {
        filepath = [self.failedTaskCacheDirectory stringByAppendingPathComponent:filePathKey];
    }
    else
    {
        filepath = [self.cacheDirectory stringByAppendingPathComponent:filePathKey];
    }
    @try
    {
        [NSKeyedArchiver archiveRootObject:object toFile:filepath];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);

    }
    @finally
    {
        NSLog(@"end");
    }
}


+(id)readCacheWithURLKey:(NSString*)URLKey andType:(CacheType)Cachetype
{
    NSString *filePath;
    NSString *filePathKey = [[StringTools base64EncodeString:URLKey] MD5Hash];

    if (Cachetype == CacheTypeFailedTask)
    {
        filePath = [NSString stringWithFormat:@"%@/%@",self.failedTaskCacheDirectory ,filePathKey];
    }
    else
    {
        filePath = [NSString stringWithFormat:@"%@/%@",self.cacheDirectory ,filePathKey];
    }
    BOOL exsit = [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    if (exsit)
    {
        id readContent;
        @try
        {
           readContent = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
        @catch (NSException *exception)
        {

            readContent = nil;
        }
        @finally {
            return readContent;
        }
    }
    else
    {
        return nil;
    }
}

+(void)removeCacheWithURLKey:(NSString*)URLKey andType:(CacheType)Cachetype
{
    NSString *filePathKey = [[StringTools base64EncodeString:URLKey] MD5Hash];

    NSString* fullFilePath = [NSString stringWithFormat:@"%@/%@",self.cacheDirectory ,filePathKey];
    @try
    {
        [[NSFileManager defaultManager] removeItemAtPath:fullFilePath error:nil];
    }
    @catch (NSException *exception) {

    }
    @finally
    {
    }
}

//设置文件不备份扩展属性
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL iOSVersion:(NSString *) iOSVersion
{
    float version = [iOSVersion floatValue];
    if (version > 5.0 && [iOSVersion isEqualToString:@"5.0.1"]==NO)
    {
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    else
    {
        const char* filePath = [[URL path] fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result== 0;
    }
}

+(void)saveFailedTaskWithTaskContent:(id)task
                             taskKey:(NSString *)key
                           CacheType:(CacheType)type
{
    [self saveCacheWithObject:task
                    ForURLKey:key
                      AndType:CacheTypeFailedTask];
}


@end
