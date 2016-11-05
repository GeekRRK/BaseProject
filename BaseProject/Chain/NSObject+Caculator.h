//
//  NSObject+Caculator.h
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"

@interface NSObject (Caculator)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end
