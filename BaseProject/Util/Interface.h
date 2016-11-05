//
//  NXHInterface.h
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  网络封装接口

#import <Foundation/Foundation.h>
#import <AFURLSessionManager.h>

typedef void (^SuccessBlock)(NSDictionary *responseObject);
typedef void (^FailureBlock)(NSError *error);

@interface Interface : NSObject

+ (void)request:(NSString *)api param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

+ (void)request2UploadFile:(NSString *)api files:(NSDictionary *)files param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
