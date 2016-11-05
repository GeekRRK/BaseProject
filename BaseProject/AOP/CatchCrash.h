//
//  CatchCrash.h
//  BaseProject
//
//  Created by UGOMEDIA on 16/11/5.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);

+ (void)uploadErrorLog;

@end
