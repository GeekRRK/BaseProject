//
//  BadCode.m
//  BaseProject
//
//  Created by UGOMEDIA on 16/11/10.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "BadCode.h"

@interface BadCode ()

@end

@implementation BadCode

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 脏代码
-(NSArray*)getArr
{
    NSArray *nameArr = [NSArray arrayWithObjects:@"Al",@"John", @"Mary",nil];
    NSMutableArray* arr=[[NSMutableArray alloc]init];
    for(int i=0;i<nameArr.count;i++){
        [arr addObject:[NSString stringWithFormat:@"iOS_%@",nameArr[i]]];
    }
    return arr;
}

// 修改后
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
