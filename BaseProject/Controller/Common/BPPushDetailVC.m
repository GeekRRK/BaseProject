//
//  PushDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPPushDetailVC.h"
#import <MBProgressHUD.h>

@interface BPPushDetailVC ()

@end

@implementation BPPushDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送详情";
}

- (void)requestPushDetail {
    NSString *api = SERVER_ADDRESS;
    
    NSString *push_id = @"推送内容id";  // 必选
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{@"id":push_id} copyItems:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(BPResponseModel *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (responseObject.status == 0) {
            
        } else {
            [BPUtil showMessage:responseObject.content];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
