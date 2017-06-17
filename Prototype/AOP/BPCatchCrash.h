//
//  BPCatchCrash.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPCatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);

+ (void)uploadErrorLog;

@end
