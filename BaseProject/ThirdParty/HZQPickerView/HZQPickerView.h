//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HZQBlock)(NSInteger index1st, NSInteger index2nd, NSInteger index3rd);

@interface HZQPickerView : UIView

+ (void)showPickerViewInVC:(UIViewController *)parentVC titles:(NSArray *)titles numOfComponent:(int)numOfComponent block:(HZQBlock)block;
    
@end
