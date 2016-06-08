//
//  Tools.m
//  xiaoqu
//
//  Created by wendy on 15/9/2.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import "FileTools.h"
#include <sys/xattr.h>

@implementation FileTools

//设置文件不备份扩展属性
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result== 0;
}

+ (BOOL)createCacheDirectoryWithDirectoryName:(NSString *)directoryName
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = [[paths firstObject] stringByAppendingPathComponent:directoryName];
    [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (isDir == NO) {
       isDir = [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return isDir;
}

+ (BOOL)removeAllFileInCacheDirectoryDirectoryName:(NSString *)directoryName
{
    BOOL isRemove = NO;

    if ([FileTools exitsCacheDirectoryWithDirectoryName:directoryName]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[FileTools directoryPathWithDirectoryName:directoryName] error:&error];
        if (error) {
            NSLog(@"移除文件出错%@",error);
            return isRemove;
        }else
        {
            isRemove = YES;
            return isRemove;
        }
    }
    return isRemove;
}

+ (BOOL)removeFileIncacheDirectoryWithFilePath:(NSString *)filePath
{
    BOOL isRemove = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [fileManager removeItemAtPath:filePath error:&error];
        if (error) {
            return isRemove;
        }else
        {
            isRemove = YES;
            return isRemove;
        }
    }
    return isRemove;
}

+ (NSString *)filePathToCacheDirectoryName:(NSString *)directoryName AndFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    if (directoryName == nil) {
        NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:fileName];
        return filePath;
    }
    NSString *directoryPath = [[paths firstObject] stringByAppendingPathComponent:directoryName];
    BOOL isExist = [FileTools exitsCacheDirectoryWithDirectoryName:directoryName];
    if (isExist == NO) {
        [FileTools createCacheDirectoryWithDirectoryName:directoryName];
    }
    NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (BOOL)exitsCacheDirectoryWithDirectoryName:(NSString *)directoryName
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = [[paths firstObject] stringByAppendingPathComponent:directoryName];
    [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    return isDir;

}

+ (BOOL)exitsCacheFileWithFilePath:(NSString*)filePath
{
    BOOL isFilePath = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (filePath) {
        isFilePath =  [fileManager fileExistsAtPath:filePath];
    }
    return isFilePath;
}

+ (NSString *)directoryPathWithDirectoryName:(NSString *)directoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = [[paths firstObject] stringByAppendingPathComponent:directoryName];
    return directoryPath;
}

+ (NSArray *)directoryContentFromDirectoryName:(NSString *)directoryName
{
    NSError *error = nil;
    NSString *directoryPath = [self directoryPathWithDirectoryName:directoryName];
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return directoryContents;

}

@end
