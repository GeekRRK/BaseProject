//
//  NXHUserModel.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  模型结合YYModel示例

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]) {
        
    }
    
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"m_id" : @"id"};
}

@end
