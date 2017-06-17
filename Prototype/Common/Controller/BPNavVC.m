//
//  BPBasicNaviVC.m
//  Topwinner
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import "BPNavVC.h"

@interface BPNavVC ()

@end

@implementation BPNavVC

- (void)viewDidLoad {
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
