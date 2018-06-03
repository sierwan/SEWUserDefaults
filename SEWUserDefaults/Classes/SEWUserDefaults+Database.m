//
//  SEWUserDefaults+Database.m
//  SEWUserDefaults
//
//  Created by YanWei on 16/10/11.
//  Copyright © 2016年 YanWei. All rights reserved.
//

#import "SEWUserDefaults+Database.h"

#import "FMDB.h"

BOOL kLogSwich = NO;

static NSString const * const kTableName = @"KeyValueTable";
static NSString const * const kTableColumnKey = @"columnKey";
static NSString const * const kTableColumnValue = @"columnValue";

@implementation SEWUserDefaults (Database)

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (FMDatabaseQueue *)databaseQueue
{
    static FMDatabaseQueue *_userDefaultsDatabaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"userDefaults.db"];
#if DEBUG
        if (kLogSwich) {
            NSLog(@"url for userDefaults.db: %@", storeURL);
        }
#endif
        _userDefaultsDatabaseQueue = [FMDatabaseQueue databaseQueueWithURL:storeURL];
    });
    return _userDefaultsDatabaseQueue;
}

- (void)createTableIfNotExist
{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *resultSet = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", kTableName];
        while ([resultSet next]) {
            
            NSInteger count = [resultSet intForColumn:@"count"];
            if (count == 0) {
                NSString *sql = [NSString stringWithFormat:@"create table %@ (%@ text primary key  not null, %@ blob)", kTableName, kTableColumnKey, kTableColumnValue];
#if DEBUG
                if (kLogSwich) {
                    NSLog(@"%@ 表不存在，执行建表语句。 SQL:%@", kTableName, sql);
                }
#endif
                
#if DEBUG
                BOOL executeResult = [db executeUpdate:sql];
#else
                [db executeUpdate:sql];
#endif
                
#if DEBUG
                if (kLogSwich) {
                    if (executeResult) {
                        NSLog(@"SQL 执行成功：%@", sql);
                    } else {
                        NSLog(@"SQL 执行失败：%@", sql);
                    }
                }
#endif
            } else {
#if DEBUG
                if (kLogSwich) {
                    NSLog(@"%@ 表已存在，不执行建表语句。", kTableName);
                }
#endif
            }
        }
    }];
}

- (BOOL)replaceIntoValueObject:(id)object forKey:(NSString *)defaultName
{
    NSAssert(object != nil && defaultName != nil, @"数据不能为空");
    
    id targetObject = nil;
    if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSData class]]) {
        targetObject = object;
    } else {
        targetObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    }
    
    NSString *sql = [NSString stringWithFormat:@"replace into %@ (%@, %@) values ('%@', '%@')", kTableName, kTableColumnKey, kTableColumnValue, defaultName, object];
    
    
    __block BOOL executeResult = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        executeResult = [db executeUpdate:sql];
#if DEBUG
        if (kLogSwich) {
            if (executeResult) {
                NSLog(@"SQL 执行成功：%@", sql);
            } else {
                NSLog(@"SQL 执行失败：%@", sql);
            }
        }
#endif
    }];
    return executeResult;
}

- (BOOL)deleteValueObjectForKey:(NSString *)defaultName
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", kTableName, kTableColumnKey, defaultName];
    
    __block BOOL executeResult = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        executeResult = [db executeUpdate:sql];
#if DEBUG
        if (kLogSwich) {
            if (executeResult) {
                NSLog(@"SQL 执行成功：%@", sql);
            } else {
                NSLog(@"SQL 执行失败：%@", sql);
            }
        }
#endif
    }];
    return executeResult;
}

- (nullable id)valueObjectForKey:(NSString *)defaultName
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", kTableName, kTableColumnKey, defaultName];
    __block id targetObject = nil;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            id object = [resultSet objectForColumn:[kTableColumnValue copy]];
            do {
                if ([object isKindOfClass:[NSNull class]]) {
                    break;
                }
                
                if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                    targetObject = object;
                    break;
                }
                
                if ([object isKindOfClass:[NSData class]]) {
                    id tempObject = [NSKeyedUnarchiver unarchiveObjectWithData:object];
                    if (tempObject) {
                        targetObject = tempObject;
                    } else {
                        targetObject = object;
                    }
                    break;
                }
                
            } while (0);
        }
    }];
    return targetObject;
}

@end
