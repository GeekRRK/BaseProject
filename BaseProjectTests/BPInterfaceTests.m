//
//  BPInterfaceTests.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BPInterfaceTests : XCTestCase

@end

@implementation BPInterfaceTests

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

@end
