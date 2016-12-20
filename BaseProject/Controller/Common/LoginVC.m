//
//  LoginVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "LoginVC.h"
#import "BPThirdParty.h"
#import <MBProgressHUD.h>

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}

- (IBAction)clickLoginBtn:(id)sender {
    // 登录
    NSString *loginApi = SERVER_ADDRESS API_LOGIN;
    
    /*
    NSDictionary *loginParam = @{FIXED_PARAMS,
                                 @"mobile":@"18516282405",
                                 @"password":[BPUtil md5:@"111111"],
                                 @"device":@"IOS"};
     */
    
    NSString *mobile = @"手机号";      // 必选
    NSString *password = @"密码";      // 必选
    NSString *device = @"设置系统";     // 必选，IOS
    
    NSDictionary *loginParam = @{FIXED_PARAMS,
                                 @"mobile":mobile,
                                 @"password":[BPUtil md5:password],
                                 @"device":device};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:loginApi param:loginParam success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 登录成功把用户信相关登录信息保存在本地
            [BPUtil saveLoginInfo:responseObject[@"content"]];
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickThirdPartyBtn:(UIButton *)sender {    
    [[BPThirdParty shareInstance] loginWithThirdParty:sender];
}

@end
