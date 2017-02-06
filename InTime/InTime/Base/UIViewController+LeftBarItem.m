//
//  UIViewController+LeftBarItem.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：视图控制器扩展，支持添加自定义返回按钮
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#import "UIViewController+LeftBarItem.h"

@implementation UIViewController (LeftBarItem)

- (void)addLeftBarItem
{
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemDidClicked:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)leftBarItemDidClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
