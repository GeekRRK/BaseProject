//
//  BPBasicNaviVC.m
//  Topwinner
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

#import "BPBasicNaviVC.h"

@interface BPBasicNaviVC ()

@end

@implementation BPBasicNaviVC

-(void)viewDidLoad{
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)buttonBack{
    [self popViewControllerAnimated:YES];
}

//- (UIViewController*)childViewControllerForStatusBarStyle{
//    return self.topViewController;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    UIViewController*topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}

@end
