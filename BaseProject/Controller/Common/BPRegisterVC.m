//
//  RegisterVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPRegisterVC.h"
#import "BPAddressModel.h"
#import <MBProgressHUD.h>

@interface BPRegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceCityTextField;

@property (strong, nonatomic) NSMutableArray *provinces;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) NSTimer *coolDownTimer;
@property (assign, nonatomic) int coolTime;
@property (assign, nonatomic) int stepTime;

@property (copy, nonatomic) NSString *provinceid;
@property (copy, nonatomic) NSString *cityid;
@property (copy, nonatomic) NSString *sex;

@end

@implementation BPRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self requestProvinces];
}

- (NSDictionary *)registrationParams {
    NSString *phone = _phoneTextField.text;
    NSString *pwd = _pwdTextField.text;
    NSString *pwdAgain = _pwdAgainTextField.text;
    NSString *code = _codeTextField.text;
    NSString *email = _emailTextField.text;
    NSString *sex = sex;
    NSString *provinceid = _provinceid;
    NSString *cityid = _cityid;
    NSString *areaid = @"";
    NSString *device = @"IOS";
    NSString *platform = @"";
    NSString *openid = @"";
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return nil;
    } else if (EmptyString(pwd)) {
        [BPUtil showMessage:@"请输入密码"]; return nil;
    } else if (![pwd isEqualToString:pwdAgain]) {
        [BPUtil showMessage:@"两次密码输入不一致"]; return nil;
    } else if (EmptyString(code)) {
        [BPUtil showMessage:@"请输入验证码"]; return nil;
    } else if (EmptyString(email)) {
        [BPUtil showMessage:@"请输入邮箱"]; return nil;
    } else if (EmptyString(sex)) {
        [BPUtil showMessage:@"请选择性别"]; return nil;
    } else if (EmptyString(provinceid)) {
        [BPUtil showMessage:@"请选择省份"]; return nil;
    } else if (EmptyString(cityid)) {
        [BPUtil showMessage:@"请选择城市"]; return nil;
    }

    NSDictionary *params = @{
                            @"mobile":phone,                    // 手机号，必选
                            @"password":[BPUtil md5:pwd],       // 密码，必选，需要进行md5
                            @"code":code,                       // 验证码，必选
                            @"email":email,                     // 邮箱，必选
                            @"sex":sex,                         // 性别id，必选，1男 2女
                            @"province_id":provinceid,          // 省份id，必选
                            @"city_id":cityid,                  // 城市id，必选
                            @"area_id":areaid,                  // 地区id，可选
                            @"device":device,                   // 设备系统，必选，IOS
                            @"platform":platform,               // 第三方平台，可选
                            @"openid":openid};                  // 第三方openid，可选
    
    return params;
}

- (IBAction)clickRegisterBtn:(id)sender {
    NSString *api = SERVER_ADDRESS;
    NSDictionary *params = [self registrationParams];
    if (params) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [BPInterface request:api param:params success:^(BPResponseModel *responseObject) {
            if (responseObject.status == 0) {
                NSLog(@"%@", responseObject);
            } else {
                [BPUtil showMessage:responseObject.content];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}

- (IBAction)clickCodeBtn:(id)sender {
    NSString *api = SERVER_ADDRESS;
    NSString *phone = _phoneTextField.text;  // 必选
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return;
    }
    
    NSDictionary *param = @{@"mobile":phone};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:param success:^(BPResponseModel *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (responseObject.status == 0) {
            // 获取成功
            [self startCountDown];
        } else {
            [BPUtil showMessage:responseObject.content];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)requestProvinces {
    // 省市列表
    NSString *api = SERVER_ADDRESS;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{} copyItems:YES];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [BPInterface request:api param:param success:^(BPResponseModel *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (responseObject.status == 0) {
            // 把获取的省市转换成BPAddressModel的数组
            _provinces = [BPAddressModel yy_modelWithDictionary:responseObject.content];
        } else {
            [BPUtil showMessage:responseObject.content];
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

- (void)startCountDown {
    _coolTime = 60;
    _stepTime = 1;
    _codeBtn.enabled = NO;
    _coolDownTimer = [NSTimer scheduledTimerWithTimeInterval:self.stepTime target:self selector:@selector(coolDownCount) userInfo:nil repeats:YES];
}

- (void)coolDownCount {
    _coolTime = _coolTime - _stepTime;
    
    [_codeBtn setTitle:[[NSString alloc] initWithFormat:@"重新获取(%d)", _coolTime] forState:UIControlStateNormal];
    
    if (self.coolTime <= 0) {
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_coolDownTimer invalidate];
        _codeBtn.enabled = YES;
    }
}

@end
