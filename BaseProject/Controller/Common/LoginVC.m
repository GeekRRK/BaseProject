//
//  LoginVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "LoginVC.h"
#import "BPThirdParty.h"

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
    NSDictionary *loginParam = @{FIXED_PARAMS, @"mobile":@"18516282405", @"password":[BPUtil md5:@"111111"], @"device":@"IOS"};
    [BPInterface request:loginApi param:loginParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            [BPUtil saveLoginInfo:responseObject[@"content"]];
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickThirdPartyBtn:(UIButton *)sender {    
    [[BPThirdParty shareInstance] loginWithThirdParty:sender];
}

@end
