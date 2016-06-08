//
//  Tools.h
//  xiaoqu
//
//  Created by wendy on 15/9/2.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTools : NSObject

+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (BOOL)createCacheDirectoryWithDirectoryName:(NSString *)directoryName;

+ (BOOL)removeAllFileInCacheDirectoryDirectoryName:(NSString *)directoryName;

+ (BOOL)removeFileIncacheDirectoryWithFilePath:(NSString*)filePath;

+ (BOOL)exitsCacheDirectoryWithDirectoryName:(NSString*)directoryName;

+ (NSString*)filePathToCacheDirectoryName:(NSString*)directoryName AndFileName:(NSString*)fileName;

+ (NSString*)directoryPathWithDirectoryName:(NSString*)directoryName;

+ (NSArray*)directoryContentFromDirectoryName:(NSString*)directoryName;

+ (BOOL)exitsCacheFileWithFilePath:(NSString*)filePath;

@end
