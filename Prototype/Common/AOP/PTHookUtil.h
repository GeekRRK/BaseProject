//
//  PTHookUtil.h
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTHookUtil : NSObject

+ (void)swizzlingInClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist;

@end
