//
//  WebDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPWebDetailVC.h"

@interface BPWebDetailVC ()

@end

@implementation BPWebDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页内容";
}

- (void)requestWebDetail {
    NSString *api = SERVER_ADDRESS API_WEB_CONTENT;
    
    NSString *webId = @"网页内容id";    // 必选
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":webId} copyItems:YES];
    [BPInterface request:api param:param success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
