//
//  TWSegmentChooseView.h
//  Topwinner
//
//  Created by apple on 17/2/20.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPSegBtn.h"

@class BPSegTitleView;

@protocol BPSegTitleViewDelegate <NSObject>

@optional

- (void)chooseSegmentView:(BPSegTitleView *)segmentChooseView didSelectItemAtIndex:(NSInteger)index;

@end

@interface BPSegTitleView : UIView

@property (nonatomic, weak) id<BPSegTitleViewDelegate> delegate;

@property (strong,nonatomic)NSArray * titleNameArr;
@property (strong,nonatomic)NSMutableArray * btnArr;
@property (strong,nonatomic)UIImage * triangleImage;//默认图片
@property (assign,nonatomic)NSInteger index;

- (instancetype)initWithArr:(NSArray *)nameArr;
- (instancetype)initWithArr:(NSArray *)nameArr withIdx:(NSInteger)index;

- (void)addChildBtn;

- (void)btnSetImageWithBtn:(BPSegBtn *)sender;

@end
