//
//  HookUtility.h
//  BaseProject
//
//  Created by UGOMEDIA on 16/11/5.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookUtility : NSObject

+ (void)swizzlingInClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist;

@end
