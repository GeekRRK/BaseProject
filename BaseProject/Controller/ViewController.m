//
//  ViewController.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "BPDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)testDB {
    NSString *tableName = @"userTable";
    
    [BPDB createUserTable:tableName];
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.m_id = @"1";
    userModel.name = @"iOS";
    userModel.tel = @"18516282405";
    [BPDB replaceModel:userModel intoTable:tableName];
    
    UserModel *curUserModel = [BPDB queryModelById:@"1" class:[userModel class] fromTable:tableName];
    
    NSLog(@"userId: %@, userName: %@, userPhone: %@", curUserModel.m_id, curUserModel.name, curUserModel.tel);
    
    [BPDB deleteModelById:@"1" fromTable:tableName];
}

@end
