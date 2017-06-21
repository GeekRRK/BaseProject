//
//  PTInterface.h
//  Prototype
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  网络封装接口

#import "PTInterface.h"
#import <AFURLSessionManager.h>
#import "PTUtil.h"
#import "PTResponseModel.h"

#define PTDEBUG
#ifndef PTDEBUG
#define SERVER_ADDRESS @""
#else
#define SERVER_ADDRESS @""
#endif

@implementation PTInterface

+ (AFURLSessionManager *)shareURLSessionMgr {
    static AFURLSessionManager *URLSessionMgr;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionMgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
        URLSessionMgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return URLSessionMgr;
}

+ (void)request:(NSString *)api
          param:(NSDictionary *)param
        success:(SuccessBlock)successBlock
        failure:(FailureBlock)failureBlock {
    
    api = [SERVER_ADDRESS stringByAppendingString:api];
    
    NSURL *URL = [NSURL URLWithString:api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSString *paramURL = [PTInterface convertParam2URL:param];
    NSData *paramData = [paramURL dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:paramData];
    
    NSURLSessionDataTask *dataTask = [[PTInterface shareURLSessionMgr] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            PTResponseModel *responseModel = [[PTResponseModel alloc] init];
            responseModel.status = [resDict[@"status"] intValue];
            responseModel.content = resDict[@"content"];
            
            successBlock(responseModel);
        }
    }];
    [dataTask resume];
}

+ (void)request2UploadFile:(NSString *)api
                     files:(NSDictionary *)files
                     param:(NSDictionary *)param
                   success:(SuccessBlock)successBlock
                   failure:(FailureBlock)failureBlock {
    
    api = [SERVER_ADDRESS stringByAppendingString:api];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:api parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSArray *sortedFileKeys = [files.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        for (int i = 0; i < files.count; ++i) {
            NSString *key = sortedFileKeys[i];
            NSString *value = files[key];
            
            NSString *fileName = [value lastPathComponent];
            NSString *extension = [fileName pathExtension];
            
            NSString *mineType = @"";
            if ([extension isEqualToString:@"jpg"]) {
                mineType = @"image/jpeg";
            } else if ([extension isEqualToString:@"png"]) {
                mineType = @"image/png";
            }
            
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:value] name:key fileName:fileName mimeType:mineType error:nil];
        }
        
        for (int i = 0; i < param.allKeys.count; ++i) {
            NSString *key = param.allKeys[i];
            NSString *value = param[key];
         
            [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] name:key];
        }
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [[PTInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            PTResponseModel *responseModel = [[PTResponseModel alloc] init];
            responseModel.status = [resDict[@"status"] intValue];
            responseModel.content = resDict[@"content"];
            
            successBlock(responseModel);
        }
    }];
    [uploadTask resume];
}

+ (NSString *)convertParam2URL:(NSDictionary *)param {
    NSString *urlStr = @"";
    
    NSArray *sortedKyes = [param.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i = 0; i < sortedKyes.count; ++i) {
        NSString *key = sortedKyes[i];
        if ([param[key] isEqualToString:@""]) {
            continue;
        }
        
        NSString *value = param[key];
        NSString *encodedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                       NULL,
                                                                                                       (CFStringRef)value,
                                                                                                       NULL,
                                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                       kCFStringEncodingUTF8 ));
        
        urlStr = [NSString stringWithFormat:@"%@&%@=%@", urlStr, key, encodedValue];
    }
    
    urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
    
    return urlStr;
}

+ (NSString *)errorResponseDataString:(NSError *)error {
    NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
    
    return errorResponse;
}

@end
