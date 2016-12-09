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
    
    if (_urlType) {
        [_webView loadHTMLString:@"" baseURL:nil];
    } else {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@""]];
        [_webView loadRequest:request];
    }
}

@end
