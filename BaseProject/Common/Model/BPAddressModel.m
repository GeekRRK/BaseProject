//
//  BPProvinceCityModel.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPAddressModel.h"

@implementation BPAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"m_id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sub" : [BPAddressModel class]};
}

@end
