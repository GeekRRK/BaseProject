//
//  LoginVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPLoginVC.h"
#import <MBProgressHUD.h>

@interface BPLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation BPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}

- (NSDictionary *)loginParams {
    NSString *phone = _phoneTextField.text;
    NSString *pwd = _pwdTextField.text;
    NSString *device = @"IOS";
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return nil;
    } else if (EmptyString(pwd)) {
        [BPUtil showMessage:@"请输入密码"]; return nil;
    }
    
    NSDictionary *params = @{
                             @"mobile":phone,                   // 必选
                             @"password":[BPUtil md5:pwd],      // 必选
                             @"device":device};                 // 必选，IOS
    
    return params;
}

- (IBAction)clickLoginBtn:(id)sender {
    NSString *api = SERVER_ADDRESS;
    NSDictionary *params = [self loginParams];
    
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

- (IBAction)clickThirdPartyBtn:(UIButton *)sender {    
    
}

@end
