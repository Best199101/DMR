//
//  SQLiteManager.m
//  xiaoqu
//
//  Created by wendy on 15/9/2.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import "SQLiteManager.h"
#import "FileTools.h"

@implementation SQLiteManager
static SQLiteManager *sqLiteManager = nil;

+(SQLiteManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqLiteManager = [[SQLiteManager alloc]init];
    });
    
    return sqLiteManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sqLiteManager == nil)
        {
            sqLiteManager = [super allocWithZone:zone];
            return sqLiteManager; //assignmentandreturnonfirstallocation
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


- (id)init
{
    if (self = [super init])
    {
        BOOL success;
        NSError *error;
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        // 数据库
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"dmr.db"];
        NSLog(@"%@",writableDBPath);
        //Sqlite 文件是否存在
        success = [fm fileExistsAtPath:writableDBPath];
        if(!success)
        {   //DB不存在，创建新的DB文件
            NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"dmr.db"];
            success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
            if(!success)
            {
                
                NSLog(@"%@",[error localizedDescription]);
            }
            else
            {
                //修改文件属性
                [FileTools addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:writableDBPath]];
                
                _database = [FMDatabase databaseWithPath:writableDBPath];
                _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:writableDBPath];
                NSLog(@"数据库路径：%@",writableDBPath);
                //for QueueDebug
                [_dataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                    [db setLogsErrors:TRUE];
                    [db setTraceExecution:TRUE];
                    if ([db open]) {
                        [db setShouldCacheStatements:YES];
                    }else
                    {
                        NSLog(@"open DataBase失败");
                    }
                }];
                
                //For Debug
                [_database setLogsErrors:TRUE];
                [_database setTraceExecution:TRUE];
                if ([_database open])
                {
                    [_database setShouldCacheStatements:YES];
                }
                else
                {
                    NSLog(@"Failed to open database.");
                }
            }
            success = NO;
        }
        if(success){
            _database = [FMDatabase databaseWithPath:writableDBPath];
            
            _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:writableDBPath];
            NSLog(@"\n数据库路径：%@",writableDBPath);

            //for QueueDebug
            [_dataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                [db setLogsErrors:TRUE];
                [db setTraceExecution:TRUE];
                if ([db open]) {
                    [db setShouldCacheStatements:YES];
                }else
                {
                    NSLog(@"open DataBase失败");
                }
            }];
            

            //For Debug
            [_database setLogsErrors:TRUE];
            [_database setTraceExecution:TRUE];
            if ([_database open]) {    //打开DB
                [_database setShouldCacheStatements:YES];
            }else{
                NSLog(@"Failed to open database.");
            }
        }
    }
    return self;
}

- (FMDatabase *) database
{
    return _database;
}

-(FMDatabaseQueue*)dataBaseQueue
{
    return _dataBaseQueue;
}

- (BOOL)executeSQL:(NSString*)sql, ... {
    
    va_list args;
    va_start(args, sql);
    BOOL result = [_database executeUpdate:sql withArgumentsInArray:nil];
    if ([_database hadError])
    {
        NSLog(@"Err %d: %@", [_database lastErrorCode], [_database lastErrorMessage]);
    }
    
    va_end(args);
    return result;
}

-(BOOL)executeSQL:(FMDatabase *) fmDB SqlString:(NSString *)sql,...
{
    va_list args;
    va_start(args, sql);
//    BOOL result = [_database executeUpdate:sql withVAListArray:args];
    BOOL result = [_database executeUpdate:sql withVAList:args];
    if ([fmDB hadError])
    {
        NSLog(@"Err %d: %@", [fmDB lastErrorCode], [fmDB lastErrorMessage]);
    }
    
    va_end(args);
    return result;
}

- (FMResultSet *)selectResult:(NSString *)sql
{    
    FMResultSet *rs = [_database executeQuery:sql];
    
    if ([_database hadError])
    {
        NSException *dbException = [NSException
                                    exceptionWithName:@"DBExecuteException"
                                    reason:[_database lastErrorMessage]
                                    userInfo:nil];
        @throw dbException;
    }
    return rs;
}

- (void)dealloc
{
    if (_database)
    {
        [_database close];
    }
    if (_dataBaseQueue) {
        [_dataBaseQueue close];
        _dataBaseQueue = nil;
    }
}

@end
