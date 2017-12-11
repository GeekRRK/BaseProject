//
//  PTInterface.h
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTResponseModel.h"

typedef void (^SuccessBlock)(PTResponseModel *responseModel);
typedef void (^FailureBlock)(NSError *error);

@interface PTInterface : NSObject

+ (void)request:(NSString *)api
          param:(NSDictionary *)param
        success:(SuccessBlock)successBlock
        failure:(FailureBlock)failureBlock;

+ (void)request:(NSString *)api
          header:(NSDictonary *)header
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
