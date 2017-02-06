//
//  Xun_BaseViewController.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/21.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：视图控制器基类
//  修改记录
//  王志鹏 2016-6-21   创建该单元

#import <UIKit/UIKit.h>

@interface Xun_BaseViewController : UIViewController



/**
 弹出登录控制器

 @param isNeed 是否需要隐藏BottomBar
 */
- (void)showLoginViewControllerNeedHideBottomBar:(BOOL)isNeed;


/**
 弹出实名认证控制器
 */
- (void)showRNAuthenController;


@end
