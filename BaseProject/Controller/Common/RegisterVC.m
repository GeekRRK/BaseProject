//
//  RegisterVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "RegisterVC.h"
#import "BPAddressModel.h"
#import <MBProgressHUD.h>

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
    
    NSString *mobile = @"手机号";          // 必选
    NSString *password = @"密码";         // 必选，需要进行md5
    NSString *code = @"验证码";            // 必选
    NSString *email = @"邮箱";            // 必选
    NSString *sex = @"性别";              // 必选，1男 2女
    NSString *province_id = @"省份id";    // 必选
    NSString *city_id = @"城市id";        // 必选
    NSString *area_id = @"地区id";        // 可选
    NSString *device = @"设备系统";        // 必选，IOS
    NSString *platform = @"第三方平台";     // 可选
    NSString *openid = @"第三方openid";    // 可选
    
    NSDictionary *codeParam = @{FIXED_PARAMS,
                                @"mobile":mobile,
                                @"password":[BPUtil md5:password],
                                @"code":code,
                                @"email":email,
                                @"sex":sex,
                                @"province_id":province_id,
                                @"city_id":city_id,
                                @"area_id":area_id,
                                @"device":device,
                                @"platform":platform,
                                @"openid":openid};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:codeApi param:codeParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)requestCode {
    // 获取验证码
    NSString *api = SERVER_ADDRESS API_VERIFICATION_TOKEN;
    
    // NSDictionary *codeParam = @{FIXED_PARAMS, @"mobile":@"18516282405"};
    
    NSString *mobile = @"手机号";  // 必选
    
    NSDictionary *param = @{FIXED_PARAMS, @"mobile":mobile};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 获取成功
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)requestProvinces {
    // 省市列表
    NSString *api = SERVER_ADDRESS API_PROVINCE_CITY;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 把获取的省市转换成BPAddressModel的数组
            _provinces = [BPAddressModel yy_modelWithDictionary:responseObject[@"content"]];
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickProvinceCityBtn:(id)sender {
    if (_provinces == nil) {
        [self requestProvinces];
    }
}

@end
