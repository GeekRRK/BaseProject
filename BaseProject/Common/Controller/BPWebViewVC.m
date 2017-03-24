//
//  NXHWebViewVC.m
//  iFan
//
//  Created by GeekRRK on 16/7/21.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPWebViewVC.h"
#import <MBProgressHUD.h>
#import <JavaScriptCore/JavaScriptCore.h>

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
    
    [self exchangeJS];
}

- (void)exchangeJS {
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
   
    context[@"CallAppNativeMethod"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        
        NSMutableArray *receiveParams = [[NSMutableArray alloc] init];
        int i = 0;
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
            
            NSString *param = [NSString stringWithFormat:@"%@", jsVal];
            [receiveParams addObject:param];
            
            ++i;
        }
        
        NSLog(@"+++++++End Log+++++++");
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [BPUtil showMessage:[NSString stringWithFormat:@"%@", receiveParams]];
        });
    };
}

@end
