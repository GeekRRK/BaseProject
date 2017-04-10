//
//  BPInterface.h
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPResponseModel.h"

typedef void (^SuccessBlock)(BPResponseModel *responseModel);
typedef void (^FailureBlock)(NSError *error);

@interface BPInterface : NSObject

+ (void)request:(NSString *)api
          param:(NSDictionary *)param
        success:(SuccessBlock)successBlock
        failure:(FailureBlock)failureBlock;

+ (void)request2UploadFile:(NSString *)api
                     files:(NSDictionary *)files
                     param:(NSDictionary *)param
                   success:(SuccessBlock)successBlock
                   failure:(FailureBlock)failureBloc;

+ (NSString *)errorResponseDataString:(NSError *)error;

@end
