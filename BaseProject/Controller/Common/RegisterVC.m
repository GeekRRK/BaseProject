//
//  RegisterVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "RegisterVC.h"
#import "BPAddressModel.h"

@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceCityTextField;

@property (strong, nonatomic) NSMutableArray *provinces;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self requestProvinces];
}

- (IBAction)clickRegisterBtn:(id)sender {
    // 注册
    NSString *codeApi = SERVER_ADDRESS API_REGISTER;
    
    //NSDictionary *codeParam = @{FIXED_PARAMS, @"mobile":@"18516282405", @"password":[BPUtil md5:@"111111"], @"code":@"6624", @"email":@"669672615@qq.com", @"sex":@"1", @"province_id":@"1", @"city_id":@"37", @"area_id":@"", @"device":@"IOS"};
    
    NSDictionary *codeParam = @{FIXED_PARAMS,
                                @"mobile":_userNameTextField.text,
                                @"password":[BPUtil md5:_pwdTextField.text],
                                @"code":_codeTextField.text,
                                @"email":_emailTextField.text,
                                @"sex":_sexTextField.text,
                                @"province_id":@"1",
                                @"city_id":@"37",
                                @"area_id":@"",
                                @"device":@"IOS"};
    
    [BPInterface request:codeApi param:codeParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)requestCode {
    // 获取验证码 content结构要变回来
    NSString *codeApi = SERVER_ADDRESS API_VERIFICATION_TOKEN;
    NSDictionary *codeParam = @{FIXED_PARAMS, @"mobile":@"18516282405"};
    [BPInterface request:codeApi param:codeParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)requestProvinces {
    // 省市列表 应该一次性返回
    NSString *launchAdApi = SERVER_ADDRESS API_PROVINCE_CITY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            _provinces = [BPAddressModel yy_modelWithDictionary:responseObject[@"content"]];
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickProvinceCityBtn:(id)sender {
    if (_provinces == nil) {
        [self requestProvinces];
    }
}

@end
