//
//  BPProvinceCityModel.h
//  BaseProject
//
//  Created by UGOMEDIA on 2016/12/9.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAddressModel : NSObject

@property (copy, nonatomic) NSString *m_id;
@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *subAddresses;

+ (NSArray *)propertyNames;

@end
