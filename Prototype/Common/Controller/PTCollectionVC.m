//
//  PTCollectionVC.m
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import "PTCollectionVC.h"
#import "PTCollectionViewCell.h"

static NSString *const reusableCell = @"Collection_Cell";

@interface PTCollectionVC () <UICollectionViewDataSource, PTCollectionViewCellDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) BOOL editable;

@end

@implementation PTCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

- (void)buildUI {
    UICollectionViewFlowLayout *flowlayout = ALLOC_INIT(UICollectionViewFlowLayout);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"PTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reusableCell];
    _collectionView = collectionView;
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
    _collectionView.dataSource = self;
    
    flowlayout.itemSize = CGSizeMake(100, 100);
    flowlayout.minimumLineSpacing = 20;
    flowlayout.minimumInteritemSpacing = 20;
    flowlayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableCell forIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

- (void)collectionViewCell:(PTCollectionViewCell *)cell didLongPress:(UILongPressGestureRecognizer *)sender {
    if (_editable) { //删除状态
        [UIView animateWithDuration:0.1 delay:0 options:0  animations:^
         {
             //顺时针旋转0.05 = 0.05 * 180 = 9°
             cell.transform=CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             //  重复                                  反向            动画时接收交互
             /**
              UIViewAnimationOptionAllowUserInteraction      //动画过程中可交互
              UIViewAnimationOptionBeginFromCurrentState     //从当前值开始动画
              UIViewAnimationOptionRepeat                    //动画重复执行
              UIViewAnimationOptionAutoreverse               //来回运行动画
              UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套的持续时间
              UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
              UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
              UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
              UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
              */
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  cell.transform=CGAffineTransformMakeRotation(0.05);
              } completion:^(BOOL finished) {}];
         }];
    }else{
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             cell.transform=CGAffineTransformIdentity;
         } completion:^(BOOL finished) {}];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _editable = NO;
}

@end
