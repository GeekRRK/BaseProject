//
//  ChangePwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ChangePwdVC.h"

@interface ChangePwdVC ()

@end

@implementation ChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (IBAction)clickChangePwdBtn:(id)sender {
    // 修改密码
    NSString *changePwdApi = SERVER_ADDRESS API_CHANGE_PWD;
    NSDictionary *changePwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"password":[BPUtil md5:@"222222"], @"oldpassword":[BPUtil md5:@"222222"]};
    [BPInterface request:changePwdApi param:changePwdParam success:^(NSDictionary *responseObject) {
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
