//
//  BPThirdParty.h
//  BaseProject
//
//  Created by GeekRRK on 2016/12/8.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPThirdParty : NSObject

+ (instancetype)shareInstance;
- (void)setupThirdParty:(NSDictionary *)launchOptions;
- (void)loginWithThirdParty:(UIButton *)sender;
- (void)shareInView:(UIView *)view;

@end
