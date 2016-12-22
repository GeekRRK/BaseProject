//
//  ChangePwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPChangePwdVC.h"
#import <MBProgressHUD.h>

@interface BPChangePwdVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;

@end

@implementation BPChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (NSDictionary *)pwdParams {
    NSString *phone = _phoneTextField.text;         // 手机号，必选
    NSString *oldPwd = _oldPwdTextField.text;       // 旧密码，必选，需要md5
    NSString *pwd = _pwdTextField.text;             // 新密码，必选，需要md5
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return nil;
    } else if (EmptyString(oldPwd)) {
        [BPUtil showMessage:@"请输入旧密码"]; return nil;
    } else if (EmptyString(pwd)) {
        [BPUtil showMessage:@"请输入新密码"]; return nil;
    }
    
    NSDictionary *params = @{FIXED_PARAMS,
                             @"mobile":phone,
                             @"password":[BPUtil md5:pwd],
                             @"oldpassword":[BPUtil md5:oldPwd]};
    
    return params;
}

- (IBAction)clickChangePwdBtn:(id)sender {
    NSString *api = SERVER_ADDRESS API_CHANGE_PWD;
    NSDictionary *params = [self pwdParams];
    if (params) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [BPInterface request:api param:params success:^(NSDictionary *responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [BPUtil showMessage:error.localizedDescription];
        }];
    }
}

@end
