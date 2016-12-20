//
//  SuggestionVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "SuggestionVC.h"

@interface SuggestionVC ()

@end

@implementation SuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
}

- (IBAction)clickSubmitBtn:(id)sender {
    // 意见反馈 返回非法数据
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *launchAdApi = SERVER_ADDRESS API_SUGGEST;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"userid":userid, @"context":@"test suggestion", @"email":@"668672615@qq.com", @"phone":@"18516282405"} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
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
