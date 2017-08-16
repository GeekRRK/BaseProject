//
//  PTCollectionViewCell.h
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTCollectionViewCell;

@protocol PTCollectionViewCellDelegate <NSObject>
@required
- (void)collectionViewCell:(PTCollectionViewCell *)cell didLongPress:(UILongPressGestureRecognizer *)sender;
@end

@interface PTCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) id<PTCollectionViewCellDelegate> delegate;

@end
