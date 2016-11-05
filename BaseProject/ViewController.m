//
//  ViewController.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculator.h"
#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.add(1).add(2).add(3).add(4).divide(5);
    }];
    
    DDLogInfo(@"%d", result);
    
    UserModel *userModel = [UserModel yy_modelWithDictionary:@{@"id":@"001", @"name":@"Al", @"tel":@"18516282405"}];
    DDLogInfo(@"%@ %@ %@", userModel.m_id, userModel.name, userModel.tel);

    NSArray *arr = [[NSArray alloc] init];
    NSLog(@"%@", arr[1]);
}

@end
