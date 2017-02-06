//
//  UIView+Extensions.m
//  niuManager
//
//  Created by 王志鹏 on 16/2/19.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：不限
//  功能描述：UIView扩展类
//  修改记录
//  王志鹏 2016-02-19  创建该单元

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

/**
 *  获取UIView或其子类的x坐标
 *
 *  @return UIView或其子类的x坐标值
 */
- (CGFloat)x
{
    return self.frame.origin.x;
}

/**
 *  设置UIView或其子类的x坐标
 *
 *  @param x 要设置的x的值
 */
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

/**
 *  获取UIView或其子类的y坐标
 *
 *  @return UIView或其子类的y坐标
 */
- (CGFloat)y
{
    return self.frame.origin.y;
}

/**
 *  设置UIView或其子类的y坐标
 *
 *  @param y 要设置y的值
 */
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/**
 *  获取UIView或其子类的宽度
 *
 *  @return UIView或其子类的宽度
 */
- (CGFloat)width
{
    return self.frame.size.width;
}

/**
 *  设置UIView或其子类的宽度
 *
 *  @param width 要设置的宽度的值
 */
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/**
 *  获取UIView或其子类的高度
 *
 *  @return UIView或其子类的高度
 */
- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 *  设置UIView或其子类的高度
 *
 *  @param height 要设置的高度的值
 */
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/**
 *  获取UIView或其子类的右边界的值
 *
 *  @return UIView或其子类右边界的值
 */
- (CGFloat)right
{
    return self.x + self.width;
}

/**
 *  获取UIView或其子类的下边界的值
 *
 *  @return UIView或其子类下边界的值
 */
- (CGFloat)bottom
{
    return self.y + self.height;
}

/**
 *  获取UIView或其子类在x方向的中心点
 *
 *  @return UIView或其子类在x方向的中心点
 */
- (CGFloat)centerX
{
    return self.center.x;
}

/**
 *  设置UIView或其子类在x方向的中心点
 *
 *  @param centerX 要设置的x方向的中心点的值
 */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

/**
 *  获取UIView或其子类在y方向的中心点
 *
 *  @return UIView或其子类在y方向的中心点
 */
- (CGFloat)centerY
{
    return self.center.y;
}

/**
 *  设置UIView或其子类在y方向的中心点
 *
 *  @param centerY 要设置的y方向的中心点的值
 */
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

@end
