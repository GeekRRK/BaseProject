//
//  TWSegmentBtn.m
//  Topwinner
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

#import "BPSegBtn.h"

@implementation BPSegBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageWidth = 14.f;
        CGFloat imageHeight = 7.f;
        _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - imageWidth)/2, frame.size.height - imageHeight, imageWidth, imageHeight)];
        [self addSubview:_bottomImageView];
    }
    return self;
}

@end
