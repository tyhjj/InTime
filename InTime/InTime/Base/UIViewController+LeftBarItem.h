//
//  UIViewController+LeftBarItem.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：视图控制器扩展，支持添加自定义返回按钮
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#import <UIKit/UIKit.h>

@interface UIViewController (LeftBarItem)

/**
 *  添加返回按钮
 */
- (void)addLeftBarItem;

/**
 *  返回按钮点击回调
 *
 *  @param sender 传入的对象
 */
- (void)leftBarItemDidClicked:(id)sender;

@end
