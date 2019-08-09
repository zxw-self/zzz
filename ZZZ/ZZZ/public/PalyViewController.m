//
//  PalyViewController.m
//  ZZZ
//
//  Created by zxw on 17/3/8.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import "PalyViewController.h"


@interface PalyViewController () <UIWebViewDelegate>

@end

@implementation PalyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.title = [self.dic valueForKey:@"name"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
    
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;//横屏
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}




- (UIWebView *)webView{
    if (!_webView) {
        
        CGFloat width = self.view.bounds.size.width;
        CGFloat heigth = self.view.bounds.size.height;
        CGSize size;
        if (heigth>width) {
            size = CGSizeMake(heigth, width);
        }else{
            size = CGSizeMake(width, heigth);
        }
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    NSURLRequest * req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self.dic valueForKey:@"url"]]];
    
    if ([[self.dic valueForKey:@"name"] isEqualToString:@"中央综合"]) {
        req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    }
    
    [self.webView loadRequest:req];
}






@end
