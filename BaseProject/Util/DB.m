//
//  NXHDB.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  数据库封闭接口

#import "DB.h"

#define CACHE_DIR                 [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define DATABASE_PATH             @"nxh.db"
#define USER_TABLE                [NSString stringWithFormat:@"usertable%@", @""]

@implementation DB

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

+ (void)createUserTable {
    NSString *createStarTable = [NSString stringWithFormat:@"create table if not exists %@ (id text primary key, name text, tel text", USER_TABLE];
    [[DB shareDateBase] executeUpdate:createStarTable];
}

+ (void)replaceModel:(id)model intoTable:(NSString *)tableName {
    [DB createUserTable];
    
//    NSString *replaceSql = [NSString stringWithFormat:
//                            @"replace into %@ (id, name, tel) values ('%@', '%@', '%@'')",
//                            tableName,
//                            userModel.m_id,
//                            userModel.name,
//                            userModel.tel];
//    [[DB shareDateBase] executeUpdate:replaceSql];
}

+ (id)queryModelById:(NSString *)token fromTable:(NSString *)tableName {
    [DB createUserTable];
    
//    UserModel *userModel = [[UserModel alloc] init];
//    
//    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where token = '%@'", tableName, token];
//    FMResultSet *resultSet = [[DB shareDateBase] executeQuery:querySql];
//    if ([resultSet next]) {
//        userModel.m_id = [resultSet stringForColumn:@"id"];
//        userModel.name = [resultSet stringForColumn:@"name"];
//        userModel.tel = [resultSet stringForColumn:@"tel"];
//        
//        return userModel;
//    }
    
    return nil;
}

@end
