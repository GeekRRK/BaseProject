//
//  ViewController.m
//  RAC
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "BPDB.h"

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
    
    [BPDB createUserTable:@"userTable"];
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.m_id = @"1";
    userModel.name = @"iOS";
    userModel.tel = @"18516282405";
    [BPDB replaceModel:userModel intoTable:@"userTable"];
    
    UserModel *curUserModel = [BPDB queryModelById:@"1" class:[userModel class] fromTable:@"userTable"];
    
    NSLog(@"%@, %@, %@", curUserModel.m_id, curUserModel.name, curUserModel.tel);
}

@end
