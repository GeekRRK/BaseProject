//
//  AppDelegate.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setRootVC];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils

- (void)setRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController *vc1 = [[ViewController alloc] init];
    ViewController *vc2 = [[ViewController alloc] init];
    ViewController *vc3 = [[ViewController alloc] init];
    
    NSArray *vcs = @[vc1, vc2, vc3];
    NSArray *titles = @[LOCALSTR(@"Homepage"), LOCALSTR(@"Video"), LOCALSTR(@"Me")];
    NSArray *tabItemImages = @[@"tabbar_homepage", @"tabbar_video", @"tabbar_me"];
    
    NSMutableArray *navCtrls = [[NSMutableArray alloc] init];
    for (int i = 0; i < vcs.count; ++i) {
        UIViewController *itemVC = vcs[i];
        itemVC.title = titles[i];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:itemVC];
        navVC.navigationBar.barTintColor = [UIColor blackColor];
        navVC.navigationBar.tintColor = [UIColor whiteColor];
        navVC.navigationBar.translucent = NO;
        [navVC.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:BP_NAVBAR_TITLE_FONTSIZE], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSString *imgName = tabItemImages[i];
        NSString *selImgName = [[NSString alloc] initWithFormat:@"%@_sel", tabItemImages[i]];
        navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i]
                                                         image:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:selImgName]
                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BP_COLOR_GREEN}
                                                 forState:UIControlStateSelected];
        
        [navCtrls addObject:navVC];
    }
    
    NSArray *navVCArray = [[NSArray alloc] initWithArray:navCtrls];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = navVCArray;
    tabBarVC.tabBar.barTintColor = [UIColor blackColor];
    tabBarVC.tabBar.tintColor = BP_COLOR_GREEN;
    tabBarVC.tabBar.translucent = NO;
    
    self.window.rootViewController = tabBarVC;
}

@end
