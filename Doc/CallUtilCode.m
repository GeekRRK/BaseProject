//
//  CallUtilCode.m
//  BaseProject
//
//  Created by UGOMEDIA on 16/11/10.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "CallUtilCode.h"
#import "UserModel.h"
#import "BPDB.h"

@interface CallUtilCode ()

@end

@implementation CallUtilCode

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 网络请求
- (void)testBPInterface {
    NSString *api = SERVER_ADDRESS API_USERINFO;
    NSDictionary *params = @{@"userId":@"1"};
    [BPInterface request:api
                   param:params
                 success:^(NSDictionary *responseObject) {
                     NSLog(@"%@", responseObject);
                 } failure:^(NSError *error) {
                     NSLog(@"%@", error.localizedDescription);
                 }];
}

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
