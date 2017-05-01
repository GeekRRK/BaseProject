//
//  TWSegmentChooseView.m
//  Topwinner
//
//  Created by apple on 17/2/20.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

#import "BPSegTitleView.h"
#import "BPSegBtn.h"

@implementation BPSegTitleView

- (instancetype)initWithArr:(NSArray *)nameArr{
    self = [super init];
    if (self) {
        _titleNameArr = nameArr;
        [self addChildBtn];
    }
    return self;
}

- (instancetype)initWithArr:(NSArray *)nameArr withIdx:(NSInteger)index{
    self = [super init];
    if (self) {
        _titleNameArr = nameArr;
        _index = index;
        [self addChildBtn];
    }
    return self;
}

- (void)addChildBtn{
    if (!_titleNameArr||_titleNameArr.count<_index)return;
    
    _btnArr = [NSMutableArray arrayWithCapacity:0];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    _triangleImage = [[UIImage imageNamed:@"triangleImage"] imageWithAlignmentRectInsets:insets];
    
    CGFloat btnWidth = 50.f;
    CGFloat btnHeight = 44.f;
    CGRect viewRect = CGRectMake(0.f, 0.f, btnWidth*_titleNameArr.count, btnHeight);
    self.frame = viewRect;
    
    for (int i = 0; i<_titleNameArr.count; i++) {
        BPSegBtn * btn = [[BPSegBtn alloc]initWithFrame:CGRectMake(i*btnWidth, 0.f, btnWidth, btnHeight)];
        
        [btn setTitle:_titleNameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAdjustsImageWhenHighlighted:NO];
        
        btn.tag = i+1;
        [self addSubview:btn];
        [_btnArr addObject:btn];
    }
    
    [self btnSetImageWithBtn:_btnArr[_index]];
}

- (void)clickBtnAction:(BPSegBtn *)sender{
    [self btnSetImageWithBtn:sender];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(chooseSegmentView:didSelectItemAtIndex:)]) {
            [self.delegate chooseSegmentView:self didSelectItemAtIndex:(sender.tag-1)];
        }
    }
}

- (void)btnSetImageWithBtn:(BPSegBtn *)sender{
    for (int i = 0; i<_btnArr.count; i++) {
        if (sender.tag != i+1) {
            BPSegBtn * btn = _btnArr[i];
            btn.bottomImageView.image = nil;
        }else{
            sender.bottomImageView.image = _triangleImage;
        }
    }
}

@end
