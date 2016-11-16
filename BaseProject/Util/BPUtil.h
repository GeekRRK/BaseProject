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

+ (void)switchLocalizedLanguage;

+ (void)setupDDLog;

+ (void)showMessage:(NSString *)message;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (NSString *)md5:(NSString *)str;

@end
