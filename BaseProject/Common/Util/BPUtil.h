//
//  BPUtil.h
//  BaseProject
//
//  Created by GeekRRK on 16/4/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  常用方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import "BPCatchCrash.h"

@interface BPUtil : NSObject

+ (void)saveLoginInfo:(NSDictionary *)dict;

+ (void)switchLocalizedLanguage;

+ (void)setupDDLog;

+ (void)showMessage:(NSString *)message;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (NSString *)md5:(NSString *)str;

+ (NSString *)getFilePathBy:(NSString *)fileName;

+ (NSMutableDictionary *)readDictBy:(NSString *)fileName;

+ (void)writeDict:(NSDictionary *)dict to:(NSString *)fileName;

+ (void)deleteFileByName:(NSString *)fileName;

+ (void)dealWithAPNs:(NSDictionary *)userInfo;

+ (NSString *)getNowTimeStamp;

+ (NSDictionary *)getUserParamDict;

@end
