//
//  ChangeUserInfoVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ChangeUserInfoVC.h"
#import <MBProgressHUD.h>

@interface ChangeUserInfoVC ()

@end

@implementation ChangeUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改用户信息";
    
    [self requestUserInfo];
}

- (void)requestUserInfo {
    // 获取用户详细信息
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *api = SERVER_ADDRESS API_USERINFO;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":TOKEN} copyItems:YES];
    [param setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:token param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 处理获取的用户信息
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickChangeBtn:(id)sender {
    // 修改用户资料
    NSString *api = SERVER_ADDRESS API_MODIFY_USERINFO;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"name":@"iOS_Developer"} copyItems:YES];
    
    NSString *name = @"姓名";            // 可选
    NSString *email = @"邮箱";           // 可选
    NSString *sex = @"性别";             // 可选，1男 2女
    NSString *province_id = @"省份id";   // 可选
    NSString *city_id = @"城市id";       // 可选
    
    /*
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS,
                                                                                   @"name":@"iOS_Developer",
                                                                                   @"email":email,
                                                                                   @"sex":sex,
                                                                                   @"province_id":province_id,
                                                                                   @"city_id":city_id} copyItems:YES];
     */
    
    [param setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    NSString *imgPath = [CACHE_DIR stringByAppendingPathComponent:@"avatar.jpg"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request2UploadFile:api files:@{@"avatar":imgPath} param:param success:^(NSDictionary *responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"status"] intValue] == 0) {
            // 修改成功
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
