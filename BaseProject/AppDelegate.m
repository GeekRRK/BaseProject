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
#import "BPThirdParty.h"
#import "JPUSHService.h"

//#define WXTabBar

/*
    13865250636
    111111
 */

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupRootVC];
    [[BPThirdParty shareInstance] setupThirdParty:launchOptions];
    /*
    // 登录 应该是客户端进行md5
    NSString *loginApi = SERVER_ADDRESS API_LOGIN;
    NSDictionary *loginParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"password":@"111111", @"device":@"IOS"};
    [BPInterface request:loginApi param:loginParam success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] intValue] == 0) {
            [BPUtil saveLoginInfo:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];*/
    
    /*
    // 修改密码 应该是客户端进行md5
    NSString *changePwdApi = SERVER_ADDRESS API_CHANGE_PWD;
    NSDictionary *changePwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"password":@"222222", @"oldpassword":@"111111"};
    [BPInterface request:changePwdApi param:changePwdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    // 找回密码 应该是客户端进行md5
    NSString *findPwdApi = SERVER_ADDRESS API_FIND_PWD;
    NSDictionary *findPwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"code":@"111111", @"password":@"111111"};
    [BPInterface request:findPwdApi param:findPwdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 获取用户详细信息
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *userinfoApi = SERVER_ADDRESS API_USERINFO;
    NSMutableDictionary *userinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":TOKEN} copyItems:YES];
    [userinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:userinfoApi param:userinfoParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 修改用户资料
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *siginid = [[NSUserDefaults standardUserDefaults] objectForKey:SIGNID];
    NSString *modifyUserinfoApi = SERVER_ADDRESS API_MODIFY_USERINFO;
    NSMutableDictionary *modifyUserinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"name":@"iOS_Developer"} copyItems:YES];
    [modifyUserinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    NSString *imgPath = [CACHE_DIR stringByAppendingPathComponent:@"avatar.png"];
    [BPInterface request2UploadFile:modifyUserinfoApi files:@{@"avatar":imgPath} param:modifyUserinfoParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    // 第三方登录，7001，未注册
    
    
    /*
    // 开屏广告 暂无
    NSString *launchAdApi = SERVER_ADDRESS API_LAUNCH_AD;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
    [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 第三方绑定
    NSString *launchAdApi = SERVER_ADDRESS API_BIND_THIRDPARTY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 第三方解绑 404
    NSString *launchAdApi = SERVER_ADDRESS API_UNBIND_THIRDPARTY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 开屏广告详情 暂无
    NSString *launchAdApi = SERVER_ADDRESS API_LAUNCHAD_DETAIL;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 省市列表 应该一次性返回
    NSString *launchAdApi = SERVER_ADDRESS API_PROVINCE_CITY;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 推送详情 不要token
    NSString *launchAdApi = SERVER_ADDRESS API_PUSH_DETAIL;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
    
    /*
    // 意见反馈 返回非法数据
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *launchAdApi = SERVER_ADDRESS API_SUGGEST;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":token, @"userid":userid, @"context":@"test suggestion", @"email":@"668672615@qq.com", @"phone":@"18516282405"} copyItems:YES];
    [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    */
    
    /*
    // 获取web内容 非法数据
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSString *launchAdApi = SERVER_ADDRESS API_WEB_CONTENT;
    NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
    [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject[@"content"]);
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
