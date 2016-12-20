//
//  VideoVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/11/24.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "VideoVC.h"
#import "WJItemsControlView.h"

@interface VideoVC () <UIScrollViewDelegate>

@property (strong, nonatomic) WJItemsControlView *itemControlView;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"新闻", @"房产", @"体育", @"美女", @"文化", @"历史", @"故事", @"汽车"];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(SCREENWIDTH * array.count, 100);
    
    for (int i = 0; i < array.count; ++i) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, SCREENHEIGHT)];
        label.text = array[i];
        label.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        [scroll addSubview:label];
    }
    
    [self.view addSubview:scroll];
    
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = SCREENWIDTH / 4.0;
    
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = array;
    
    __weak typeof (scroll)weakScrollView = scroll;
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        [weakScrollView scrollRectToVisible:CGRectMake(index*weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
    }];
    [self.view addSubview:_itemControlView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.x;
    offset = offset / CGRectGetWidth(scrollView.frame);
    [_itemControlView moveToIndex:offset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.x;
    offset = offset / CGRectGetWidth(scrollView.frame);
    [_itemControlView endMoveToIndex:offset];
}

@end
