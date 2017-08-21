//
//  PTCollectionViewCell.m
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import "PTCollectionViewCell.h"

@interface PTCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation PTCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //长按手势
    UILongPressGestureRecognizer *longpressGesutre=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture:)];
    //长按时间为1秒
    longpressGesutre.minimumPressDuration=1;
    //允许15秒中运动
    longpressGesutre.allowableMovement=15;
    //所需触摸1次
    longpressGesutre.numberOfTouchesRequired=1;
    [self addGestureRecognizer:longpressGesutre];
}

//长按手势监听
- (void)handleLongpressGesture:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {  //第一次触发执行  避免触发多次
        if ([self.delegate respondsToSelector:@selector(collectionViewCell:didLongPress:)]) {
            _deleteBtn.hidden = NO;
            [self.delegate collectionViewCell:self didLongPress:sender];
        }
    }
}

@end
