//
//  NextVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/1.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "NextVC.h"
#import <Masonry.h>
#import "BPSegTitleView.h"

@interface NextVC ()

@property (strong, nonatomic) BPSegTitleView *typeChooseView;

@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试";
    
    self.tabBar.hidden = YES;
    [self addChildViewControllers];
    
    [self setNaviUI];
    
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:testView];
    
    [testView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
}

-(void)addChildViewControllers{
    UIViewController *vc1 = [[UIViewController alloc] init];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [self addChildViewController:vc3];
}

- (void)setNaviUI{
    _typeChooseView = [[BPSegTitleView alloc]initWithArr:@[@"全部", @"热门", @"关注"] withIdx:0];
    _typeChooseView.delegate = self;
    self.navigationItem.titleView = _typeChooseView;
}

- (void)chooseSegmentView:(BPSegTitleView *)segmentChooseView didSelectItemAtIndex:(NSInteger)index{
    self.selectedIndex = index;
}

@end
