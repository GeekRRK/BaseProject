//
//  WebDetailVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPWebDetailVC.h"
#import "BPWebModel.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BPUserModel.h"

@interface BPWebDetailVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BPWebDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@""]];
    [_webView loadRequest:request];
}

@end
