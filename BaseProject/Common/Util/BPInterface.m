//
//  BPInterface.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//
//  网络封装接口

#import "BPInterface.h"
#import "Base64.h"
#import "NSData+AES.h"

#define ENCRYPT         @"ENCRYPT"
#define SIGN_KEY        @"l1ctZ[N8I2+H{q^HKA[C"
#define AES_ECB_KEY     @"p)w]Y|&!X3mDWi:J"

@implementation BPInterface

+ (AFURLSessionManager *)shareURLSessionMgr {
    static AFURLSessionManager *URLSessionMgr;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionMgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    });
    
    return URLSessionMgr;
}

+ (void)request:(NSString *)api
          param:(NSDictionary *)param
        success:(SuccessBlock)successBlock
        failure:(FailureBlock)failureBlock {
    
    NSURL *URL = [NSURL URLWithString:api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSString *paramURL = [BPInterface convertParam2URL:param];
    
#ifdef ENCRYPT
    NSString *sign = [BPInterface signFromUrl:paramURL];
    paramURL = [NSString stringWithFormat:@"%@&sign=%@", paramURL, sign];
#endif
    
    NSData *paramData = [paramURL dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:paramData];
    
    [BPInterface shareURLSessionMgr].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask = [[BPInterface shareURLSessionMgr] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
        #ifdef ENCRYPT
            NSDictionary *resDict = [BPInterface convertEncryptedData2Dict:responseObject];
            BOOL res = [BPInterface preprocessResponseDict:resDict];
            if (res) {
                successBlock(resDict);
            }
        #else
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            successBlock(resDict);
        #endif
        }
    }];
    [dataTask resume];
}

+ (void)request2UploadFile:(NSString *)api
                     files:(NSDictionary *)files
                     param:(NSDictionary *)param
                   success:(SuccessBlock)successBlock
                   failure:(FailureBlock)failureBlock {
    
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
    
        NSArray *sortedParamKeys = [param.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSDictionary *curParam = param;
#ifdef ENCRYPT
        NSDictionary * signedParams = [BPInterface signedParamsFrom:param];
        curParam = signedParams;
        sortedParamKeys = [signedParams.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
#endif
        
        for (int i = 0; i < curParam.count; ++i) {
            NSString *key = sortedParamKeys[i];
            NSString *value = curParam[key];
         
            [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] name:key];
        }
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [[BPInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            
        #ifdef ENCRYPT
            NSDictionary *resDict = [BPInterface convertEncryptedData2Dict:responseObject];
            BOOL res = [BPInterface preprocessResponseDict:resDict];
            if (res) {
                successBlock(resDict);
            }
        #else
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            successBlock(resDict);
        #endif
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

+ (NSString *)signFromUrl:(NSString *)urlStr {
    NSString *wait2Md5Str = [urlStr stringByAppendingString:SIGN_KEY];
    NSString *sign = [BPUtil md5:wait2Md5Str];
    
    return sign;
}

+ (NSDictionary *)signedParamsFrom:(NSDictionary *)param {
    NSString *urlStr = [BPInterface convertParam2URL:param];
    NSString *sign = [BPInterface signFromUrl:urlStr];

    NSMutableDictionary *signedDict = [NSMutableDictionary dictionaryWithDictionary:param];
    [signedDict setObject:sign forKey:@"sign"];
    
    return signedDict;
}

+ (NSDictionary *)convertEncryptedData2Dict:(NSData *)responseObject {
    NSString *base64DecodedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *aesData = [base64DecodedStr base64DecodedData];

    NSData *base64Data = [aesData AES128DecryptedDataWithKey:AES_ECB_KEY];
    
    NSString *base64Str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    NSString *decodedStr = [base64Str base64DecodedString];
    
    if (decodedStr == nil) {
        [BPUtil showMessage:@"Encryted data is not correct."];
        return nil;
    }

    NSData *jsonAsData = [decodedStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:jsonAsData options:NSJSONReadingAllowFragments error:nil];
    
    return resDict;
}

+ (BOOL)preprocessResponseDict:(NSDictionary *)dict {
    if ([dict[@"status"] intValue] == -1) {
        return NO;
    }
    
    return YES;
}

@end
