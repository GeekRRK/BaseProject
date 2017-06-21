//
//  PTCatchCrash.m
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  http://www.jianshu.com/p/ea1e6b210b27

#import "PTCatchCrash.h"

@implementation PTCatchCrash

void uncaughtExceptionHandler(NSException *exception) {
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *crashTime = [formatter stringFromDate:[NSDate date]];
    NSArray *stackArray = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"crashTime: %@ Exception reason: %@\nException name: %@\nException stack:%@", crashTime, name, reason, stackArray];
    NSString *errorLogPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"error.log"];
    NSError *error = nil;
    BOOL isSuccess = [exceptionInfo writeToFile:errorLogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (!isSuccess) {
        DDLogInfo(@"Failed to save crash info: %@", error.userInfo);
    }
}

+ (void)uploadErrorLog {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *errorLogPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"error.log"];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    
    if ([fileManager fileExistsAtPath:errorLogPath]) {
        [fileLogger.logFileManager createNewLogFile];
        NSString *newLogFilePath = [fileLogger.logFileManager sortedLogFilePaths].firstObject;
        NSError *error = nil;
        NSString *errorLogContent = [NSString stringWithContentsOfFile:errorLogPath encoding:NSUTF8StringEncoding error:nil];
        BOOL isSuccess = [errorLogContent writeToFile:newLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (!isSuccess) {
            DDLogInfo(@"Failed to save crash info: %@", error.userInfo);
        } else {
            NSError *error = nil;
            BOOL isSuccess = [fileManager removeItemAtPath:errorLogPath error:&error];
            if (!isSuccess) {
                DDLogInfo(@"Failed to delete original crash file: %@", error.userInfo);
            }
        }
        
        NSArray *logFilePaths = [fileLogger.logFileManager sortedLogFilePaths];
        for (NSUInteger i = 0; i < logFilePaths.count; i++) {
            NSString *logFilePath = logFilePaths[i];
            NSLog(@"%@", logFilePath);
        }
    }
}

@end
