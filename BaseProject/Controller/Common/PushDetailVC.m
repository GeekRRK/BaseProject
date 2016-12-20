//
//  PushDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "PushDetailVC.h"
#import <MBProgressHUD.h>

@interface PushDetailVC ()

@end

@implementation PushDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送详情";
}

- (void)requestPushDetail {
    // 推送详情
    NSString *api = SERVER_ADDRESS API_PUSH_DETAIL;
    
    NSString *push_id = @"推送内容id";  // 必选
    
    // NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":push_id} copyItems:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 处理获取到的推送详情
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
