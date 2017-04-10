//
//  SuggestionVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPSuggestionVC.h"
#import <MBProgressHUD.h>

@interface BPSuggestionVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *contextTextView;

@end

@implementation BPSuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
}

- (NSDictionary *)suggestionParams {
    NSString *phone = _phoneTextField.text;             // 手机，可选
    NSString *email = _emailTextField.text;             // 邮箱，必选
    NSString *context = _contextTextView.text;          // 意见内容，必选
    
    if (EmptyString(phone)) {
        [BPUtil showMessage:@"请输入手机号"]; return nil;
    } else if (EmptyString(email)) {
        [BPUtil showMessage:@"请输入邮箱"]; return nil;
    } else if (EmptyString(context)) {
        [BPUtil showMessage:@"请输入意见内容"]; return nil;
    }
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                    @"userid":userid,
                                                                                    @"context":context,
                                                                                    @"email":email,
                                                                                    @"phone":phone} copyItems:YES];
    
    return params;
}

- (IBAction)clickSubmitBtn:(id)sender {
    NSString *api = SERVER_ADDRESS;
    
    NSDictionary *params = [self suggestionParams];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:api param:params success:^(BPResponseModel *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (responseObject.status == 0) {
            
        } else {
            [BPUtil showMessage:responseObject.content];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

@end
