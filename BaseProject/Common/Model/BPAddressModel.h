//
//  BPProvinceCityModel.h
//  BaseProject
//
//  Created by GeekRRK on 2016/12/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAddressModel : NSObject

@property (copy, nonatomic) NSString *m_id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *level;
@property (strong, nonatomic) NSMutableArray *sub;

@end
