//
//  Xun_BaseTabBarController.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：分栏控制器基类
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#import "Xun_BaseTabBarController.h"

@implementation Xun_BaseTabBarController

+ (void)load
{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:Xun_ColorFromHex(0x7D7D7D)} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:Xun_BaseBlueColor} forState:UIControlStateSelected];
    
    [UITabBar appearance].barTintColor = Xun_ColorFromHex(0x7D7D7D);
    [UITabBar appearance].backgroundColor = Xun_ColorFromHex(0xF8F8F8);
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

@end
