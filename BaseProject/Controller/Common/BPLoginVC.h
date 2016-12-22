//
//  LoginVC.h
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AfterLogin)(void);

@interface BPLoginVC : UIViewController

@property (strong, nonatomic) AfterLogin afterLoginBlock;

@end
