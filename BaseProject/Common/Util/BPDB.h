//
//  BPDB.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  数据库封闭接口

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface BPDB : NSObject

+ (void)createUserTable:(NSString *)tableName;

+ (void)replaceModel:(id)model intoTable:(NSString *)tableName;

+ (id)queryModelById:(NSString *)mId class:(Class)class fromTable:(NSString *)tableName;

+ (void)deleteModelById:(NSString *)mId fromTable:(NSString *)tableName;

@end
