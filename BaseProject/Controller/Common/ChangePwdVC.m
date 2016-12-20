//
//  ChangePwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ChangePwdVC.h"
#import <MBProgressHUD.h>

@interface ChangePwdVC ()

@end

@implementation ChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (IBAction)clickChangePwdBtn:(id)sender {
    // 修改密码
    NSString *api = SERVER_ADDRESS API_CHANGE_PWD;
    // NSDictionary *param = @{FIXED_PARAMS, @"mobile":@"13865250636", @"password":[BPUtil md5:@"222222"], @"oldpassword":[BPUtil md5:@"222222"]};
    
    NSString *mobile = @"手机号";          // 必选
    NSString *password = @"密码";          // 必选，需要md5
    NSString *oldpassword = @"旧密码";     // 必选，需要md5
    NSDictionary *param = @{FIXED_PARAMS,
                            @"mobile":mobile,
                            @"password":[BPUtil md5:password],
                            @"oldpassword":[BPUtil md5:oldpassword]};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 修改成功
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
