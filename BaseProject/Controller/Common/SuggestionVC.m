//
//  SuggestionVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "SuggestionVC.h"
#import <MBProgressHUD.h>

@interface SuggestionVC ()

@end

@implementation SuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
}

- (IBAction)clickSubmitBtn:(id)sender {
    // 意见反馈 返回非法数据
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *api = SERVER_ADDRESS API_SUGGEST;
    
    NSString *context = @"意见内容";        // 必选
    NSString *email = @"邮箱";             // 必选
    NSString *phone = @"手机";             // 可选
    
    // NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"userid":userid, @"context":@"test suggestion", @"email":@"668672615@qq.com", @"phone":@"18516282405"} copyItems:YES];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS,
                                                                                   @"userid":userid,
                                                                                   @"context":context,
                                                                                   @"email":email,
                                                                                   @"phone":phone} copyItems:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 提交成功
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
