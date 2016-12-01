//
//  NextVC.m
//  BaseProject
//
//  Created by UGOMEDIA on 2016/12/1.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "NextVC.h"
#import <Masonry.h>

@interface NextVC ()

@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试";
    
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:testView];
    
    [testView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@150);
    }];
}

@end
