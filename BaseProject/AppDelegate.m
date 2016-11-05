//
//  AppDelegate.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CatchCrash.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupDDLog];
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
    ViewController *vc4 = [[ViewController alloc] init];
    
    NSArray *vcs = @[vc1, vc2, vc3, vc4];
    NSArray *titles = @[@"Tab1", @"Tab2", @"Tab3", @"Tab4"];
    NSArray *tabItemImages = @[@"icon_tab1", @"icon_tab2", @"icon_tab3", @"icon_tab4"];
    
    NSMutableArray *navCtrls = [[NSMutableArray alloc] init];
    for (int i = 0; i < vcs.count; ++i) {
        UIViewController *itemVC = vcs[i];
        itemVC.title = titles[i];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:itemVC];
        navVC.navigationBar.barTintColor = [UIColor greenColor];
        navVC.navigationBar.tintColor = [UIColor whiteColor];
        navVC.navigationBar.translucent = NO;
        [navVC.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSString *imgName = tabItemImages[i];
        NSString *selImgName = [[NSString alloc] initWithFormat:@"%@_sel", tabItemImages[i]];
        navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i]
                                                         image:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:selImgName]
                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]}
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor greenColor]}
                                                 forState:UIControlStateSelected];
        
        [navCtrls addObject:navVC];
    }
    
    NSArray *navVCArray = [[NSArray alloc] initWithArray:navCtrls];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = navVCArray;
    tabBarVC.tabBar.barTintColor = [UIColor yellowColor];
    tabBarVC.tabBar.translucent = NO;
    
    self.window.rootViewController = tabBarVC;
}

- (void)setupDDLog {
    [CatchCrash uploadErrorLog];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

@end
