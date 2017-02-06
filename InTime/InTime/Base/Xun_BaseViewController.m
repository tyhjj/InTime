//
//  Xun_BaseViewController.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/21.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：视图控制器基类
//  修改记录
//  王志鹏 2016-6-21   创建该单元

#import "Xun_BaseViewController.h"
#import "Xun_LoginController.h"
#import "Xun_RNAuthenticationController.h"

@interface Xun_BaseViewController ()

@end

@implementation Xun_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Xun_ColorFromHex(0xF6F6F6);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Public
- (void)showLoginViewControllerNeedHideBottomBar:(BOOL)isNeed
{
    Xun_LoginController *loginVC = [[Xun_LoginController alloc] init];
    if (isNeed) {
        loginVC.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)showRNAuthenController
{
    Xun_RNAuthenticationController *rnVC = [[Xun_RNAuthenticationController alloc] init];
    [self.navigationController pushViewController:rnVC animated:YES];
}

@end
