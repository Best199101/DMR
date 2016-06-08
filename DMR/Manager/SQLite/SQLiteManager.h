//
//  SQLiteManager.h
//  xiaoqu
//
//  Created by wendy on 15/9/2.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface SQLiteManager : NSObject
{
    @private
    FMDatabase *_database;
    FMDatabaseQueue *_dataBaseQueue;
}

+(SQLiteManager *)shareInstance;
- (FMDatabaseQueue*)dataBaseQueue;
- (FMDatabase *) database;
- (BOOL)executeSQL:(NSString *)sql,...;
- (BOOL)executeSQL:(FMDatabase *) fmDB SqlString:(NSString *)sql,...;
- (FMResultSet *)selectResult:(NSString *)sql;

@end
