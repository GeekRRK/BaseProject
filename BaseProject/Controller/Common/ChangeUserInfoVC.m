//
//  ChangeUserInfoVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ChangeUserInfoVC.h"

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
    NSString *userinfoApi = SERVER_ADDRESS API_USERINFO;
    NSMutableDictionary *userinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":TOKEN} copyItems:YES];
    [userinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:userinfoApi param:userinfoParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (IBAction)clickChangeBtn:(id)sender {
    // 修改用户资料
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *siginid = [[NSUserDefaults standardUserDefaults] objectForKey:SIGNID];
    NSString *modifyUserinfoApi = SERVER_ADDRESS API_MODIFY_USERINFO;
    NSMutableDictionary *modifyUserinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"name":@"iOS_Developer"} copyItems:YES];
    [modifyUserinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    NSString *imgPath = [CACHE_DIR stringByAppendingPathComponent:@"avatar.jpg"];
    [BPInterface request2UploadFile:modifyUserinfoApi files:@{@"avatar":imgPath} param:modifyUserinfoParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            NSLog(@"%@", responseObject);
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
