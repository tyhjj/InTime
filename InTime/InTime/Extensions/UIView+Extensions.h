//
//  UIView+Extensions.h
//  niuManager
//
//  Created by 王志鹏 on 16/2/19.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：不限
//  功能描述：UIView扩展类
//  修改记录
//  王志鹏 2016-02-19  创建该单元

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
