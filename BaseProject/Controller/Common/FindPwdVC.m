//
//  FindPwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "FindPwdVC.h"
#import <MBProgressHUD.h>

@interface FindPwdVC ()

@end

@implementation FindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (IBAction)clickConfirmBtn:(id)sender {
    // 找回密码
    NSString *api = SERVER_ADDRESS API_FIND_PWD;
    
    NSString *mobile = @"手机号";      // 必选
    NSString *code = @"验证码";        // 必选
    NSString *password = @"密码";      // 必选
    
    // NSDictionary *param = @{FIXED_PARAMS, @"mobile":@"13865250636", @"code":@"4348", @"password":[BPUtil md5:@"222222"]};
    
    NSDictionary *param = @{FIXED_PARAMS,
                            @"mobile":mobile,
                            @"code":code,
                            @"password":[BPUtil md5:password]};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 修改密码成功
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
