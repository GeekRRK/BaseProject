//
//  PTCatchCrash.h
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTCatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);

+ (void)uploadErrorLog;

@end
