//
//  CaculatorMaker.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    return ^CaculatorMaker *(int value){
        _result += value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))sub {
    return ^CaculatorMaker *(int value){
        _result -= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))muilt {
    return ^CaculatorMaker *(int value){
        _result *= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide {
    return ^CaculatorMaker *(int value){
        _result /= value;
        return self;
    };
}

@end
