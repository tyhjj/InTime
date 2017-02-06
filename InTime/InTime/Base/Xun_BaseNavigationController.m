//
//  Xun_BaseNavigationController.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/21.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：导航控制器基类
//  修改记录
//  王志鹏 2016-6-21   创建该单元

#import "Xun_BaseNavigationController.h"

@interface Xun_BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation Xun_BaseNavigationController

+ (void)initialize
{
    // 1.获得bar对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = Xun_ColorRGB(252, 252, 252);
    
    // 2.设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = Xun_ColorFromHex(0x333333);
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = Xun_BaseBlueColor;
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //让支持了自定义的按钮之后继续支持侧滑返回上一界面
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

@end
