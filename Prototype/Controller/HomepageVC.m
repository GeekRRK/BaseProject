//
//  ViewController.m
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "HomepageVC.h"
#import "PTCodeView.h"
#import "PTXibView.h"

@interface HomepageVC ()


@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 80)];
    btn.backgroundColor =  [UIColor redColor];
    [btn addTarget:self action:@selector(jump2NextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    PTCodeView *codeView = [[PTCodeView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(btn.frame) + 20, 120, 80)];
    [self.view addSubview:codeView];
    
    PTCodeModel *codeModel = [[PTCodeModel alloc] init];
    codeModel.title = @"CButton";
    codeView.codeModel = codeModel;
    
    PTCodeModel *xibModel = [[PTCodeModel alloc] init];
    xibModel.title = @"XButton";
    PTXibView *xibView = [PTXibView viewWithModel:xibModel];
    xibView.frame = CGRectMake(100, CGRectGetMaxY(codeView.frame) + 20, 120, 80);
    [self.view addSubview:xibView];
}

- (void)jump2NextVC {
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
