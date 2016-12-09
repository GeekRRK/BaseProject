//
//  NXHWebViewVC.m
//  iFan
//
//  Created by UGOMEDIA on 16/7/21.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import "BPWebViewVC.h"

@interface BPWebViewVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BPWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *content = _webModel.content;
    if (_webModel.type == 0) {
        [_webView loadHTMLString:content baseURL:nil];
    } else if (_webModel.type == 1) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:content]];
        [_webView loadRequest:request];
    }
}

@end
