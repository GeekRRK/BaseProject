//
//  PTXibView.h
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTCodeModel.h"

@interface PTXibView : UIView

@property (strong, nonatomic) PTCodeModel *codeModel;

+ (instancetype)viewWithModel:(PTCodeModel *)codeModel;

@end
