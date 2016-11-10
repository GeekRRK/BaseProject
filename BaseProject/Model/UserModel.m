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

// Negative example
-(NSArray*)getArr
{
    NSArray *nameArr = [NSArray arrayWithObjects:@"Al",@"John", @"Mary",nil];
    NSMutableArray* arr=[[NSMutableArray alloc]init];
    for(int i=0;i<nameArr.count;i++){
        [arr addObject:[NSString stringWithFormat:@"iOS_%@",nameArr[i]]];
    }
    return arr;
}

// Positive example
- (NSArray *)userNames {
    NSArray *exampleNames = @[@"Al", @"John", @"Mary"];
    
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (int i = 0; i < exampleNames.count; ++i) {
        NSString *name = [NSString stringWithFormat:@"iOS_%@", exampleNames[i]];
        [names addObject:name];
    }
    
    return names;
}

@end
