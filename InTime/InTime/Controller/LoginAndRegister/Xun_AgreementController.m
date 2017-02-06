//
//  Xun_AgreementController.m
//  InTime
//
//  Created by xunsmart on 2017/1/17.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_AgreementController.h"

@interface Xun_AgreementController ()
{
    UIView *bottomView_;
}

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation Xun_AgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"点时贷服务协议";
    [self addLeftBarItem];
}

- (void)setUp
{
    bottomView_ = [UIView new];
    bottomView_.frame = CGRectMake(0, self.view.height - 40 - 64, kXunScreenWidth, 40);
    [self.view addSubview:bottomView_];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.tag = 1001;
    agreeBtn.frame = CGRectMake(0, 0, 60, 35);
    agreeBtn.centerY = bottomView_.height / 2.0;
    agreeBtn.centerX = bottomView_.width / 2 * 0.5;
    agreeBtn.backgroundColor = Xun_BaseBlueColor;
    agreeBtn.layer.cornerRadius = 5.0f;
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreenBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView_ addSubview:agreeBtn];
    
    UIButton *disAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disAgreeBtn.tag = 1002;
    disAgreeBtn.frame = CGRectMake(0, 0, 60, 35);
    disAgreeBtn.centerY = bottomView_.height / 2.0;
    disAgreeBtn.centerX = bottomView_.width / 2 * 1.5;
    disAgreeBtn.backgroundColor = Xun_BaseBlueColor;
    disAgreeBtn.layer.cornerRadius = 5.0f;
    [disAgreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [disAgreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [disAgreeBtn addTarget:self action:@selector(agreenBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView_ addSubview:disAgreeBtn];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kXunScreenWidth, self.view.height - bottomView_.height - 64)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Xun_AppAgressmentUrl]]];
    [self.view addSubview:self.webView];
}

#pragma mark -
#pragma mark Action
- (void)agreenBtnClicked:(UIButton *)button
{
    BOOL isAgree = NO;
    if (button.tag == 1001) {
        isAgree = YES;
    }
    else
    {
        isAgree = NO;
    }
    
    if (self.IsReadAgreementHandler) {
        self.IsReadAgreementHandler(isAgree);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
