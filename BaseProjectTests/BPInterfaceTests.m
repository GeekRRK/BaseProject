//
//  BPInterfaceTests.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MBProgressHUD.h>

@interface BPInterfaceTests : XCTestCase

@end

@implementation BPInterfaceTests

// 网络请求
- (void)testBPInterface {
    NSString *api = SERVER_ADDRESS API_USERINFO;
    NSDictionary *params = @{@"userId":@"1"};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api
                   param:params
                 success:^(BPResponseModel *responseObject) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     
                     NSLog(@"%@", responseObject);
                 } failure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     
                     NSLog(@"%@", error.localizedDescription);
                 }];
}

@end
