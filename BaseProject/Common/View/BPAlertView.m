//
//  BPAlertView.m
//  BaseProject
//
//  Created by GeekRRK on 2016/11/25.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPAlertView.h"

static UIViewController *curParentVC;
static BPAlertBlock curBlock;

@implementation BPAlertView

- (void)showAlertView:(UIViewController *)parentVC block:(BPAlertBlock)block {
    curParentVC = parentVC;
    curBlock = block;
    
    [self showAlertView];
}

- (void)showAlertView {
    self.frame = curParentVC.view.bounds;
    [curParentVC.view addSubview:self];
    
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

- (IBAction)clickCancelBtn:(id)sender {
    [self hideAlertView];
}

- (IBAction)clickConfirmBtn:(id)sender {
    curBlock(@"iOS");
    [self hideAlertView];
}

- (IBAction)clickShadowView:(id)sender {
    [self hideAlertView];
}

@end
