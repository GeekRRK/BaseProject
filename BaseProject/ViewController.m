//
//  ViewController.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculator.h"
#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:imgView];
    NSString *imageName = NSLocalizedString(@"avatar", nil);
    UIImage *image = [UIImage imageNamed:imageName];
    imgView.image = image;
}

@end
