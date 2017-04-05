//
//  BPUtil.h
//  BaseProject
//
//  Created by GeekRRK on 2017/1/13.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPUtil : NSObject

+ (void)showMessage:(NSString *)message;

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

+ (int)getAgeFromBirthday:(NSString *)birthday;

+ (UIImage*) getVideoPreViewImage:(NSString *)videoPath;

+ (UIImage *)getLocalVideoFirstImage:(NSString *)videoPath;

+ (UIImage *)getVideoFirstImage:(NSString *)videoPath;

+ (UIViewController *)getCurrentVC;

+ (BOOL)isTodayWithDateStr:(NSString *)dateStr;

+ (UIImage *)snapshot;

@end
