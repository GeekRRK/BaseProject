//
//  BPInterface.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  网络封装接口

#import <Foundation/Foundation.h>
#import <AFURLSessionManager.h>

#define USERID                      @"bp_userid"
#define SIGNID                      @"bp_signid"
#define TOKEN                       @"bp_token"
#define TIMEDIFF                    @"bp_timediff"

#define FIXED_PARAMS                @"timestamp":[BPUtil getNowTimeStamp], @"version":@"1.0"

#define API_VERIFICATION_TOKEN      @"/User/MobileCode/getCode"
#define API_REGISTER                @"/User/Account/register"
#define API_LOGIN                   @"/User/Account/Login"
#define API_CHANGE_PWD              @"/User/Safe/setPwd"
#define API_FIND_PWD                @"/User/Safe/backPwd"
#define API_USERINFO                @"/User/Info/getInfo"
#define API_MODIFY_USERINFO         @"/User/Info/setInfo"
#define API_THIRDPARTY_LOGIN        @"/User/platform/login"
#define API_LAUNCH_AD               @"/Other/Adv/getLaunch"
#define API_BIND_THIRDPARTY         @"/User/platform/bind"
#define API_UNBIND_THIRDPARTY       @"/User/platform/remove"
#define API_LAUNCHAD_DETAIL         @"/Other/Adv/getLaunchInfo"
#define API_PROVINCE_CITY           @"/Other/District/getList"
#define API_PUSH_DETAIL             @"/Other/Push/getInfo"
#define API_SUGGEST                 @"/Other/Feedback/send"
#define API_WEB_CONTENT             @"/Other/Web/getHtml"

typedef void (^SuccessBlock)(NSDictionary *responseObject);
typedef void (^FailureBlock)(NSError *error);

@interface BPInterface : NSObject

+ (void)request:(NSString *)api param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

+ (void)request2UploadFile:(NSString *)api files:(NSDictionary *)files param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
