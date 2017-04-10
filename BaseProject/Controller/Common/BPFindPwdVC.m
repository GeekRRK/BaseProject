//
//  FindPwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPFindPwdVC.h"
#import <MBProgressHUD.h>

@interface BPFindPwdVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTextField;

@end

@implementation BPFindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (NSDictionary *)pwdParams {
    NSString *phone = _phoneTextField.text;
    NSString *code = _codeTextField.text;
    NSString *pwd = _pwdTextField.text;
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return nil;
    } else if (EmptyString(code)) {
        [BPUtil showMessage:@"请输验证码"]; return nil;
    } else if (EmptyString(pwd)) {
        [BPUtil showMessage:@"请输密码"]; return nil;
    } else if (![pwd isEqualToString:_pwdAgainTextField.text]) {
        [BPUtil showMessage:@"两次输入密码不一致"]; return nil;
    }
    
    NSDictionary *params = @{
                             @"mobile":phone,                    // 手机号，必选
                             @"code":code,                       // 验证码，必选
                             @"password":[BPUtil md5:pwd]};      // 密码，必选
    
    return params;
}

- (IBAction)clickConfirmBtn:(id)sender {
    NSString *api = SERVER_ADDRESS;
    NSDictionary *params = [self pwdParams];
    
    if (params) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [BPInterface request:api param:params success:^(BPResponseModel *responseObject) {
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
}

@end
