//
//  PushDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "PushDetailVC.h"

@interface PushDetailVC ()

@end

@implementation PushDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送详情";
}

- (void)requestPushDetail {
    // 推送详情
    NSString *launchAdApi = SERVER_ADDRESS API_PUSH_DETAIL;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
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
