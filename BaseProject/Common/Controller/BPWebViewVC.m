//
//  NXHWebViewVC.m
//  iFan
//
//  Created by GeekRRK on 16/7/21.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPWebViewVC.h"
#import <MBProgressHUD.h>

@interface BPWebViewVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BPWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *content = _webModel.content;
    if (_webModel.type == 0) {
        [_webView loadHTMLString:content baseURL:nil];
    } else if (_webModel.type == 1) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:content]];
        [_webView loadRequest:request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
