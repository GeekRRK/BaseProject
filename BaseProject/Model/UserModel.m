//
//  UserModel.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  模型结合YYModel示例

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"m_id" : @"id"};
}

+ (NSArray *)propertyNames {
    return @[@"m_id", @"name", @"tel"];
}

@end
