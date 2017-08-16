//
//  PTUtil.m
//  Prototype
//
//  Created by GeekRRK on 16/4/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "PTUtil.h"
#import <CommonCrypto/CommonCrypto.h>

#define IMAGE_MAX_SIZE_WIDTH 640
#define IMAGE_MAX_SIZE_GEIGHT 960

@implementation PTUtil

+ (void)switchLocalizedLanguage {
    NSArray *langArr1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language1 = langArr1.firstObject;
    NSLog(@"Before switch：%@", language1);
    
    NSArray *lans = @[@"zh-Hans"];
    [[NSUserDefaults standardUserDefaults] setObject:lans forKey:@"AppleLanguages"];
    
    NSArray *langArr2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language2 = langArr2.firstObject;
    NSLog(@"After switch：%@", language2);
}

+ (void)showMessage:(NSString *)message {
    if (message == nil || [message isEqualToString:@""]) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc] init];
    
    CGRect labelRect = [message boundingRectWithSize:CGSizeMake(290, 9000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName, nil] context:nil];
    
    label.frame = CGRectMake(10, 5, labelRect.size.width, labelRect.size.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREENWIDTH - labelRect.size.width - 20)/2, SCREENHEIGHT - 100, labelRect.size.width+20, labelRect.size.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getFilePathBy:(NSString *)fileName {
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:fileName];
}

+ (NSMutableDictionary *)readDictBy:(NSString *)fileName {
    NSString *filepath = [PTUtil getFilePathBy:fileName];
    NSMutableDictionary *apps = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    if(apps == nil){
        apps = [[NSMutableDictionary alloc] init];
        if([apps writeToFile:filepath atomically:YES]){
            apps = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
        }
    }
    
    return apps;
}

+ (void)writeDict:(NSDictionary *)dict to:(NSString *)fileName {
    NSString *path = [PTUtil getFilePathBy:fileName];
    [dict writeToFile:path atomically:YES];
}

+ (void)deleteFileByName:(NSString *)fileName {
    NSString *filePath = [PTUtil getFilePathBy:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSString *)getNowTimeStamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (UIImage *)fitSmallImage:(UIImage *)image {
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<IMAGE_MAX_SIZE_WIDTH && image.size.height<IMAGE_MAX_SIZE_GEIGHT)
    {
        return image;
    }
    CGSize size = [PTUtil fitsize:image.size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}

+ (CGSize)fitsize:(CGSize)thisSize {
#define IMAGE_MAX_SIZE_WIDTH 640
#define IMAGE_MAX_SIZE_GEIGHT 960
    if(thisSize.width == 0 && thisSize.height ==0)
        return CGSizeMake(0, 0);
    CGFloat wscale = thisSize.width/IMAGE_MAX_SIZE_WIDTH;
    CGFloat hscale = thisSize.height/IMAGE_MAX_SIZE_GEIGHT;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    return newSize;
}

+ (void)blurView:(UIView *)view {
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [view addSubview:blurEffectView];
    } else {
        view.backgroundColor = [UIColor blackColor];
    }
}

@end
