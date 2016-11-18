//
//  BPAlertView.m
//  BaseProject
//
//  Created by UGOMEDIA on 2016/11/18.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "BPAlertView.h"

static UIViewController *curParentVC;
static BPAlertBlock curBlock;

@implementation BPAlertView

+ (void)showParentVC:(UIViewController *)parentVC block:(BPAlertBlock)block {
    curParentVC = parentVC;
    curBlock = block;
    
    BPAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"BPAlertView" owner:nil options:nil] firstObject];
    alertView.frame = curParentVC.view.bounds;
    [parentVC.view addSubview:alertView];
}

- (void)clickConfirmBtn {
    [self hideAlertView];
    
    curBlock();
}

- (void)clickCancelBtn {
    [self hideAlertView];
}

- (void)showAlertView {
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hideAlertView {
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
