//
//  SynchronizeManager.h
//  xiaoqu
//
//  Created by wendy on 15/9/4.
//  Copyright (c) 2015年 Neighbourhood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@class ConcernAndBlackModel;


/**
 *  三张表名
 */
extern NSString *const BlackList;
extern NSString *const ConcernList;
extern NSString *const CreateTime;

@interface SynchronizeManager : NSObject


/**
 *  同步本地数据库
 *
 *  @param masterIssueArray 内容数组
 *  @param tableName        表名
 */
-(void)synchronizeData:(NSArray*)masterIssueArray
             tableName:(NSString*)tableName;
/**
 *  根据表名查找表所有内容
 *
 *  @param tableName 表名
 *
 *  @return 数组 {model1,model2}
 */
- (NSArray*)findAllMasterWithTableName:(NSString*)tableName;

/**
 *  根据表名+匹配条件查询内容
 *
 *  @param tableName 表名
 *  @param match      匹配条件 目前传uid
 *
 *  @return 查询结果数组 @{model1,model2}
 */
- (NSArray*)findIssuesInTable:(NSString *)tableName Match:(NSString *)match;

/**
 *  根据表名+匹配条件删除内容
 *
 *  @param tableName 表名
 *  @param match     匹配内容
 *
 *  @return 是否成功
 */
- (BOOL)deleteIssueInTable:(NSString *)tableName Match:(NSString *)match;

/**
 *  插入数据到指定表名
 *
 *  @param tableName 表名
 *  @param model     数据
 *
 *  @return 是否成功
 */
-(BOOL)addIssueInTable:(NSString *)tableName Model:(ConcernAndBlackModel *)model;

@end
