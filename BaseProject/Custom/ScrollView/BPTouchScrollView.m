//
//  BPTouchScrollView.m
//  BaseProject
//
//  Created by GeekRRK on 16/6/12.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPTouchScrollView.h"

@implementation BPTouchScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches = NO;
    }
    
    return self;
}

// default returns YES if view isn't a UIControl
// Returns whether to cancel touches related to the content subview and start dragging.
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    // 即使触摸到的是一个 UIControl (如子类：UIButton), 我们也希望拖动时能取消掉动作以便响应滚动动作
    return YES;
}

@end
