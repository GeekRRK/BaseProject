//
//  BPUtil.h
//  BaseProject
//
//  Created by GeekRRK on 16/4/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPUtil : NSObject

+ (void)showMessage:(NSString *)message;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)getFilePathBy:(NSString *)fileName;
+ (NSMutableDictionary *)readDictBy:(NSString *)fileName;
+ (void)writeDict:(NSDictionary *)dict to:(NSString *)fileName;
+ (void)deleteFileByName:(NSString *)fileName;
+ (NSString *)getNowTimeStamp;
+ (UIImage *)fitSmallImage:(UIImage *)image;
+ (CGSize)fitsize:(CGSize)thisSize;

@end
