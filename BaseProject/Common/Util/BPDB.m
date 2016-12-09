//
//  BPDB.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  数据库封闭接口

#import "BPDB.h"
#import "BPUserModel.h"

#define CACHE_DIR                 [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define DATABASE_PATH             @"bp.db"

@implementation BPDB

+ (FMDatabase *)shareDateBase {
    static FMDatabase *db;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSString *filePath = [CACHE_DIR stringByAppendingPathComponent:DATABASE_PATH];
        db = [FMDatabase databaseWithPath:filePath];
        if (![db open]) {
            db = nil;
        }
    });
    
    return db;
}

+ (void)createUserTable:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (m_id text primary key, name text, tel text)", tableName];
    [[BPDB shareDateBase] executeUpdate:sql];
}

+ (void)replaceModel:(id)model intoTable:(NSString *)tableName {
    [BPDB createUserTable:tableName];
    
    Class class = [model class];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSArray *propertyNames = [class performSelector:@selector(propertyNames)];
#pragma clang diagnostic pop
    
    NSString *sql = [NSString stringWithFormat:@"replace into %@ (", tableName];
    for (int i = 0; i < propertyNames.count; ++i) {
        NSString *key = propertyNames[i];
        
        if (i == propertyNames.count - 1) {
            sql = [NSString stringWithFormat:@"%@%@", sql, key];
        } else {
            sql = [NSString stringWithFormat:@"%@%@,", sql, key];
        }
    }
    sql = [sql stringByAppendingString:@") values ("];
    
    for (int i = 0; i < propertyNames.count; ++i) {
        NSString *key = propertyNames[i];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *value = [model performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
        
        if (i == propertyNames.count - 1) {
            sql = [NSString stringWithFormat:@"%@'%@'", sql, value];
        } else {
            sql = [NSString stringWithFormat:@"%@'%@',", sql, value];
        }
    }
    sql = [sql stringByAppendingString:@")"];

    [[BPDB shareDateBase] executeUpdate:sql];
}

+ (id)queryModelById:(NSString *)mId class:(Class)class fromTable:(NSString *)tableName {
    [BPDB createUserTable:tableName];
    
    id model = [[class alloc] init];
    
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where m_id = '%@'", tableName, mId];
    FMResultSet *resultSet = [[BPDB shareDateBase] executeQuery:querySql];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSArray *propertyNames = [class performSelector:@selector(propertyNames)];
#pragma clang diagnostic pop
    
    if ([resultSet next]) {
        for (int i = 0; i < resultSet.columnCount; ++i) {
            NSString *value = [resultSet stringForColumnIndex:i];
            [model setValue:value forKey:propertyNames[i]];
        }
        
        return model;
    }
    
    return nil;
}

+ (void)deleteModelById:(NSString *)mId fromTable:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where groupid = '%@'", tableName, mId];
    [[BPDB shareDateBase] executeUpdate:sql];
}


@end
