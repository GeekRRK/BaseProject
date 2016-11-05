//
//  CaculatorMaker.h
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (assign, nonatomic) int result;

- (CaculatorMaker *(^)(int))add;
- (CaculatorMaker *(^)(int))sub;
- (CaculatorMaker *(^)(int))muilt;
- (CaculatorMaker *(^)(int))divide;

@end
