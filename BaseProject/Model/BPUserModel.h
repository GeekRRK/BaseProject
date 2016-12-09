//
//  UserModel.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  模型结合YYModel示例

#import <Foundation/Foundation.h>

@interface BPUserModel : NSObject

@property (copy, nonatomic) NSString *m_id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *tel;

+ (NSArray *)propertyNames;

@end
