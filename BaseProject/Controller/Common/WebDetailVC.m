//
//  WebDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "WebDetailVC.h"

@interface WebDetailVC ()

@end

@implementation WebDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页内容";
}

- (void)requestWebDetail {
    // 获取web内容
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *webApi = SERVER_ADDRESS API_WEB_CONTENT;
    NSMutableDictionary *webParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [BPInterface request:webApi param:webParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
