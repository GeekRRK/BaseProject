//
//  AppDelegate.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AppDelegate.h"
#import "HomepageVC.h"
#import "VideoVC.h"
#import "MeVC.h"
#import <WXTabBarController.h>
#import "JPUSHService.h"
#import "BPTabbarController.h"
#import "BPNavigationController.h"

//#define WXTabBar

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupRootVC];
    
    /*
    NSString *api = SERVER_ADDRESS API_CHANGE_AVATAR;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
    [param setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    
    NSString *path = [CACHE_DIR stringByAppendingPathComponent:@"avatar.png"];
    [BPInterface request2UploadFile:api files:@{@"avatar":path} param:param success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
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


#pragma mark - rootViewController

- (void)setupRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomepageVC *homepageVC = [[HomepageVC alloc] init];
    VideoVC *videoVC = [[VideoVC alloc] init];
    MeVC *meVC = [[MeVC alloc] init];
    
    NSArray *vcs = @[homepageVC, videoVC, meVC];
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
 
#ifndef WXTabBar
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = navCtrls;
    tabBarVC.tabBar.barTintColor = [UIColor blackColor];
    tabBarVC.tabBar.tintColor = BP_COLOR_GREEN;
    tabBarVC.tabBar.translucent = NO;
    
    self.window.rootViewController = tabBarVC;
#else
    WXTabBarController *tabBarVC = [[WXTabBarController alloc] init];
    tabBarVC.viewControllers = navCtrls;
    tabBarVC.tabBar.barTintColor = [UIColor blackColor];
    tabBarVC.tabBar.tintColor = BP_COLOR_GREEN;
    tabBarVC.tabBar.translucent = NO;
    UINavigationController *tabBarNavVC = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
    
    self.window.rootViewController = tabBarNavVC;
#endif
}

#pragma mark - APNs

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [BPUtil dealWithAPNs:userInfo];
}

@end
