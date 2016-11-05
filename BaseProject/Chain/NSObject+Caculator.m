//
//  NSObject+Caculator.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+ (int)makeCaculators:(void (^)(CaculatorMaker *))block {
    CaculatorMaker *mgr = [[CaculatorMaker alloc] init];
    block(mgr);
    
    return mgr.result;
}

@end
