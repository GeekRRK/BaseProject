//
//  ThirdPartyBindingVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPThirdPartyBindingVC.h"

@interface BPThirdPartyBindingVC ()

@end

@implementation BPThirdPartyBindingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三方绑定解绑";
}

- (IBAction)clickBindingBtn:(id)sender {
    // 第三方绑定
    NSString *launchAdApi = SERVER_ADDRESS API_BIND_THIRDPARTY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
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

- (IBAction)clickUnbindingBtn:(id)sender {
    // 第三方解绑
    NSString *launchAdApi = SERVER_ADDRESS API_UNBIND_THIRDPARTY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
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
