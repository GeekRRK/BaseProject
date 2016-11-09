//
//  HookUtility.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPHookUtil : NSObject

+ (void)swizzlingInClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist;

@end
