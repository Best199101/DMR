//
//  SynchronizeManager.m
//  dameiren
//
//  Created by wang on 15/9/4.
//  Copyright (c) 2015年 shklx. All rights reserved.
//

#import "SynchronizeManager.h"
#import "SQLiteManager.h"
#import "ConcernAndBlackListModel.h"
#import "ConcernAndBlackListAPI.h"
#import <FMDB.h>
#import "Global.h"


NSString *const BlackList = @"BlackList";
NSString *const ConcernList = @"ConcernList";
NSString *const CreateTime = @"CreateTime";


@interface SynchronizeManager()<APIRequestManagerDelegate>

@property (strong,nonatomic) ConcernAndBlackListAPI *concernAndBlackListAPI;

@end

@implementation SynchronizeManager

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"login"
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"logOut"
                                                 object:nil];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SQLiteManager shareInstance];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(login)
                                                    name:@"login"
                                                  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(logout)
                                                    name:@"logOut"
                                                  object:nil];

    }
    return self;
}

#pragma mark - 通知响应

-(void)login
{
//    [self.concernAndBlackListAPI startRequestWithUid:MainTabBar.currentUser.uid
//                                          CreateTime:@0];
}

-(void)logout
{

}

#pragma mark - 网络回调

-(void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager
{
}


-(void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager
{
    NSDictionary* json = [apiManager fetchDataWithTransformer:nil];
    ConcernAndBlackListModel *list = [MTLJSONAdapter modelOfClass:[ConcernAndBlackListModel class]
                                               fromJSONDictionary:json
                                                            error:nil];
    if (list.concernlist) {
        [self synchronizeData:list.concernlist tableName:ConcernList];
    }
    if (list.blacklist) {
        [self synchronizeData:list.blacklist tableName:BlackList];
    }
}

- (void)synchronizeData:(NSArray *)Array tableName:(NSString *)tableName
{
    FMDatabase *database = [SQLiteManager shareInstance].database;
    [database beginTransaction];
    @try
    {
        [self deleteLocalIssueData:tableName broker:database];
        [self saveLocalIssueData:Array tableName:tableName broker:database];
    }
    @catch (NSException *exception)
    {
        [database rollback];
    }
    @finally
    {
        [database commit];
    }
}

-(BOOL)addIssueInTable:(NSString *)tableName Model:(ConcernAndBlackModel *)model
{
    if (model.headurl.length    > 0
     && model.nickname.length   > 0
     && model.uid.length        > 0)
    {
        FMDatabase*db = [SQLiteManager shareInstance].database;
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (uid,nickname,level,headurl,currentuid,ismaster) values(?,?,?,?,?,?)",tableName];
        if ([tableName isEqualToString:ConcernList])
        {
        }

        return  [[SQLiteManager shareInstance]executeSQL:db
                                               SqlString:sql,model.uid,
                 model.nickname,
                 model.level,
                 model.headurl,
                 UserId,
                 model.ismaster];
    }
    else
        return NO;

}

- (BOOL)deleteIssueInTable:(NSString *)tableName Match:(NSString *)match
{
    NSString *sql = [NSString stringWithFormat:@"Delete from %@ where uid = '%@' and currentuid = '%@'",tableName,match,UserId];
    FMDatabase* db = [SQLiteManager shareInstance].database;
    if ([tableName isEqualToString:ConcernList])
    {
    }
    return [db executeUpdate:sql];
}


- (NSArray*)findIssuesInTable:(NSString *)tableName Match:(NSString *)match
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where uid = '%@' and currentuid = '%@'",tableName,match,UserId];
    __block NSMutableArray *array = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [SQLiteManager shareInstance].dataBaseQueue;
    if ([tableName isEqualToString:BlackList]) {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                ConcernAndBlackModel *model = [ConcernAndBlackModel new];
                model.uid = [rs stringForColumn:@"uid"];
                model.nickname = [rs stringForColumn:@"nickname"];
                model.headurl = [rs stringForColumn:@"headurl"];
                model.level = [NSNumber numberWithInteger:[rs intForColumn:@"level"]];
                model.currentuid = UserId;
                model.ismaster = [NSNumber numberWithInt:[rs intForColumn:@"ismaster"]];
                [array addObject:model];
            }
            [rs close];
        }];
        return array;
        
    }
    else if ([tableName isEqualToString:ConcernList])
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next])
            {
                ConcernAndBlackModel *model = [ConcernAndBlackModel new];
                model.uid = [rs stringForColumn:@"uid"];
                model.nickname = [rs stringForColumn:@"nickname"];
                model.headurl = [rs stringForColumn:@"headurl"];
                model.level = [NSNumber numberWithInteger:[rs intForColumn:@"level"]];
                model.currentuid = UserId;
                model.ismaster = [NSNumber numberWithInt:[rs intForColumn:@"ismaster"]];
                [array addObject:model];
            }
            [rs close];
        }];
        return array;
    }
    else if ([tableName isEqualToString:CreateTime])
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                NSDate *createtime = [rs dateForColumn:@"createTime"];
                [array addObject:createtime];
            }
            [rs close];
        }];
        return array;
    }
    return nil;

}

- (NSArray *)findAllMasterWithTableName:(NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where currentuid = '%@'",tableName,UserId];
    __block NSMutableArray *array = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [SQLiteManager shareInstance].dataBaseQueue;
    if ([tableName isEqualToString:BlackList]) {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                ConcernAndBlackModel *model = [ConcernAndBlackModel new];
                model.uid = [rs stringForColumn:@"uid"];
                model.nickname = [rs stringForColumn:@"nickname"];
                model.headurl = [rs stringForColumn:@"headurl"];
                model.level = [NSNumber numberWithInteger:[rs intForColumn:@"level"]];
                model.currentuid = [rs stringForColumn:@"currentuid"];
                model.ismaster = [NSNumber numberWithInt:[rs intForColumn:@"ismaster"]];
                [array addObject:model];
            }
            [rs close];
        }];
        return array;
        
    }
    else if ([tableName isEqualToString:ConcernList])
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                ConcernAndBlackModel *model = [ConcernAndBlackModel new];
                model.uid = [rs stringForColumn:@"uid"];
                model.nickname = [rs stringForColumn:@"nickname"];
                model.headurl = [rs stringForColumn:@"headurl"];
                model.level = [NSNumber numberWithInteger:[rs intForColumn:@"level"]];
                model.currentuid = [rs stringForColumn:@"currentuid"];
                model.ismaster = [NSNumber numberWithInt:[rs intForColumn:@"ismaster"]];
                [array addObject:model];
            }
            [rs close];
        }];
        return array;
    }
    else if ([tableName isEqualToString:CreateTime])
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                NSDate *createtime = [rs dateForColumn:@"createtime"];
                [array addObject:createtime];
            }
            [rs close];
        }];
        return array;
    }
    return nil;
}

-(void)deleteLocalIssueData:(NSString *)tableName broker:(FMDatabase *)db
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    [[SQLiteManager shareInstance] executeSQL:db SqlString:sql];
}

-(void)saveLocalIssueData:(NSArray *)newIssueArray
                 tableName:(NSString *)tableName
                    broker:(FMDatabase *)db
{
    for (id issue in newIssueArray)
    {
        [self saveData:issue tableName:tableName broker:db];
    }
}


-(void)saveData:(id )issue
      tableName:(NSString *)tableName
         broker:(FMDatabase *)db
{
    if ([tableName isEqualToString:BlackList])
    {
        ConcernAndBlackModel *model = issue;
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (uid,nickname,level,headurl,currentuid,ismaster) values(?,?,?,?,?,?)",BlackList];
        [[SQLiteManager shareInstance]executeSQL:db
                                       SqlString:sql,model.uid,
                                                     model.nickname,
                                                     model.level,
                                                     model.headurl,
                                                     UserId,
                                                     model.ismaster];
    }
    else if ([tableName isEqualToString:ConcernList])
    {
        ConcernAndBlackModel *model = issue;
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (uid,nickname,level,headurl,currentuid,ismaster) values(?,?,?,?,?,?)",ConcernList];
        [[SQLiteManager shareInstance]executeSQL:db
                                       SqlString:sql,model.uid,
                                                     model.nickname,
                                                     model.level,
                                                     model.headurl,
                                                     UserId,
                                                     model.ismaster];
    }
    else if ([tableName isEqualToString:CreateTime])
    {
        NSDate *createtime = issue;
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (uid,currentuid) values(?,?)",CreateTime];
        [[SQLiteManager shareInstance]executeSQL:db
                                       SqlString:sql,createtime,UserId];
    }
    
}

-(ConcernAndBlackListAPI *)concernAndBlackListAPI
{
    if (_concernAndBlackListAPI == nil)
    {
        _concernAndBlackListAPI = [ConcernAndBlackListAPI new];
        _concernAndBlackListAPI.apiMangerCallBackDelegate = self;
    }
    return _concernAndBlackListAPI;
}

@end
