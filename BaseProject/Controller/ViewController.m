//
//  ViewController.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "HZQPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 60);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn {
    [HZQPickerView showPickerViewInVC:self titles:@[@[@"1", @"2", @"3"], @[@"a", @"b", @"c"], @[@"小", @"中", @"大"]] numOfComponent:3 block:^(NSInteger index1st, NSInteger index2nd, NSInteger index3rd) {
        NSLog(@"col1: %zd, col2: %zd, col3: %zd", index1st, index2nd, index3rd);
    }];
}

@end
