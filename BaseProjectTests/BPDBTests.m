//
//  BPDBTests.m
//  BaseProject
//
//  Created by UGOMEDIA on 16/11/11.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserModel.h"
#import "BPDB.h"

@interface BPDBTests : XCTestCase

@end

@implementation BPDBTests

// 数据库操作
- (void)testBPDB {
    NSString *tableName = @"userTable";
    
    // 创建表
    [BPDB createUserTable:tableName];
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.m_id = @"1";
    userModel.name = @"iOS";
    userModel.tel = @"18516282405";
    
    // 增、改
    [BPDB replaceModel:userModel intoTable:tableName];
    
    // 查
    UserModel *curUserModel = [BPDB queryModelById:@"1" class:userModel.class fromTable:tableName];
    
    NSLog(@"userId: %@, userName: %@, userPhone: %@", curUserModel.m_id, curUserModel.name, curUserModel.tel);
    
    // 删
    [BPDB deleteModelById:@"1" fromTable:tableName];
}

@end
