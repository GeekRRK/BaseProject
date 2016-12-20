//
//  FindPwdVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "FindPwdVC.h"

@interface FindPwdVC ()

@end

@implementation FindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (IBAction)clickConfirmBtn:(id)sender {
    // 找回密码
    NSString *findPwdApi = SERVER_ADDRESS API_FIND_PWD;
    NSDictionary *findPwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"code":@"4348", @"password":[BPUtil md5:@"222222"]};
    [BPInterface request:findPwdApi param:findPwdParam success:^(NSDictionary *responseObject) {
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
