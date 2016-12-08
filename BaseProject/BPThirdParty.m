//
//  BPThirdParty.m
//  BaseProject
//
//  Created by UGOMEDIA on 2016/12/8.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "BPThirdParty.h"

// ThirdParty
#import "BaiduMobStat.h"
#import <Bugly/Bugly.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

// ThirdParty
#define BAIDUMTJ_APPKEY             @"2dff9c21ad"
#define BUGLY_APPID                 @"1f48bde97b"
#define JPUSH_APPKEY                @"6bc6e9883a2021ded0ea79cb"
#define JPUSH_CHANNEL               @"AppStore"
#define JPUSH_ISPRODUCT             NO
#define MOB_APPKEY                  @"199b4b61d6eaa"

@interface BPThirdParty() <JPUSHRegisterDelegate>

@end

@implementation BPThirdParty

#pragma mark - ThirdParty

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static BPThirdParty *thirdParty;
    dispatch_once(&onceToken, ^{
        thirdParty = [[BPThirdParty alloc] init];
    });
    
    return thirdParty;
}

- (void)setupThirdParty:(NSDictionary *)launchOptions {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupBaiduMTJ];
        [self setupBugly];
        [self setupMob];
        [self setupJPush:launchOptions];
    });
}

#pragma mark - BaiduMTJ

- (void)setupBaiduMTJ {
    /*
     Version: 4.3.0
     JavaScriptCore.framework
     Security.framework
     CoreLocation.framework
     SystemConfiguration.framework
     CoreTelephony.framework
     CoreGraphics.framework
     UIKit.framework
     Foundation.framework
     libz.1.2.5.tbd
     libstdc++.tbd
     */
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:BAIDUMTJ_APPKEY];
}

#pragma mark - Bugly

- (void)setupBugly {
    // pod 'Bugly'
    [Bugly startWithAppId:BUGLY_APPID];
}

#pragma mark - Mob

- (void)setupMob {
    /*
     # 主模块(必须)
     pod 'ShareSDK3'
     # Mob 公共库(必须) 如果同时集成SMSSDK iOS2.0:可看此注意事项：http://bbs.mob.com/thread-20051-1-1.html
     pod 'MOBFoundation'
     
     # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
     pod 'ShareSDK3/ShareSDKUI'
     
     # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
     pod 'ShareSDK3/ShareSDKPlatforms/QQ'
     pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
     pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
     # 扩展模块（在调用可以弹出我们UI分享方法的时候是必需的）
     pod 'ShareSDK3/ShareSDKExtension'
     */
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:MOB_APPKEY
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

#pragma mark - JPush

- (void)setupJPush:(NSDictionary *)launchOptions {
    /*
     CFNetwork.framework
     CoreFoundation.framework
     CoreTelephony.framework
     SystemConfiguration.framework
     CoreGraphics.framework
     Foundation.framework
     UIKit.framework
     Security.framework
     libz.tbd (Xcode7以下版本是libz.dylib)
     AdSupport.framework (获取IDFA需要；如果不使用IDFA，请不要添加)
     UserNotifications.framework (Xcode8及以上)
     libresolv.tbd (JPush 2.2.0及以上版本需要, Xcode7以下版本是libresolv.dylib)
     */
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:JPUSH_CHANNEL
                 apsForProduction:JPUSH_ISPRODUCT
            advertisingIdentifier:nil];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)loginWithThirdParty:(UIButton *)sender {
    SSDKPlatformType platformType;
    NSString *platform;
    if (sender.tag == 1) {
        if (![QQApiInterface isQQInstalled]) {
            [BPUtil showMessage:@"您未安装QQ客户端，无法用QQ登录"];
            return;
        }
        platformType = SSDKPlatformTypeQQ;
        platform = @"QQ";
    } else if (sender.tag == 2) {
        if (![WXApi isWXAppInstalled]) {
            [BPUtil showMessage:@"您未安装微信客户端，无法用微信登录"];
            return;
        }
        platformType = SSDKPlatformTypeWechat;
        platform = @"WX";
    } else if (sender.tag == 3) {
        if (![WeiboSDK isWeiboAppInstalled]) {
            [BPUtil showMessage:@"您未安装微博客户端，无法用微博登录"];
            return;
        }
        platformType = SSDKPlatformTypeSinaWeibo;
        platform = @"WB";
    }
    
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               if (state == SSDKResponseStateSuccess) {
                   NSString *APIAddr = SERVER_ADDRESS @"";
                   
                   NSDictionary *param = @{@"platform":platform, @"openid":user.uid, @"nickname":user.nickname, @"headface":user.icon};
                   [BPInterface request:APIAddr param:param success:^(NSDictionary *responseObject) {
                       if ([responseObject[@"error"] intValue] == 0) {
                           [BPUtil showMessage:@"登录成功"];
                           
                           NSDictionary *keyValue = responseObject[@"content"];
                           NSLog(@"%@", keyValue);
                       } else {
                           [BPUtil showMessage:@"登录失败"];
                       }
                   } failure:^(NSError *error) {
                       NSLog(@"%@", error.localizedDescription);
                   }];
               } else {
                   NSLog(@"%@",error);
               }
           }];
}

@end
