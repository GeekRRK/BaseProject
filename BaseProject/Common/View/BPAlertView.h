//
//  BPAlertView.h
//  BaseProject
//
//  Created by GeekRRK on 2016/11/25.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPAlertBlock)(NSString *name);

@interface BPAlertView : UIView

- (void)showAlertView:(UIViewController *)parentVC block:(BPAlertBlock)block;

@end
