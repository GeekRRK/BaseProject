//
//  PTTouchTableView.m
//  Prototype
//
//  Created by GeekRRK on 16/7/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "PTTouchTableView.h"

@implementation PTTouchTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches = NO;
    }
    
    // iterate over all the UITableView's subviews
    for (id view in self.subviews)
    {
        // looking for a UITableViewWrapperView
        if ([NSStringFromClass([view class])
             isEqualToString:@"UITableViewWrapperView"])
        {
            // this test is necessary for safety and because a
            // "UITableViewWrapperView" is NOT a UIScrollView in iOS7
            if([view isKindOfClass:[UIScrollView class]])
            {
                // turn OFF delaysContentTouches in the hidden subview
                UIScrollView *scroll = (UIScrollView *)view;
                scroll.delaysContentTouches = NO;
            }
            break;
        }
    }
    
    return self;
}

@end
