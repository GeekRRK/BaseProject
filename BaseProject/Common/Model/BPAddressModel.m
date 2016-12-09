//
//  BPProvinceCityModel.m
//  BaseProject
//
//  Created by UGOMEDIA on 2016/12/9.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "BPAddressModel.h"

@implementation BPAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"m_id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subAddresses" : [BPAddressModel class]};
}

@end
