//
//  Xun_ProductInfoController.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_ProductInfoController.h"

@interface Xun_ProductInfoController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation Xun_ProductInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:_htmlStr baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.webView.width = kXunScreenWidth;
}

- (void)setHtmlStr:(NSString *)htmlStr
{
    _htmlStr = htmlStr;
    
    [self.webView loadHTMLString:_htmlStr baseURL:nil];
}

@end
