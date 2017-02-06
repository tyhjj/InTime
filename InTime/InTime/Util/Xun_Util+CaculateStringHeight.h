//
//  Xun_Util+CaculateStringHeight.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/7/12.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：动态计算文本工具类
//  修改记录
//  王志鹏 2016-7-12   创建该单元

#import "Xun_Util.h"

@interface Xun_Util (CaculateStringHeight)

/**
 *  计算NSAttributeString的高度
 *
 *  @param content 要计算的文字的内容
 *  @param width   给定的宽度
 *
 *  @return 返回计算之后的高度
 */
+ (CGFloat)getAttributeStringMaxHeightWithContent:(NSAttributedString *)content width:(CGFloat)width;

/**
 *  计算普通字符串的高度
 *
 *  @param content 要计算的文字的内容
 *  @param width   给定的宽度
 *  @param font    该段文字的字体
 *
 *  @return 计算之后的高度
 */
+ (CGFloat)getNormalStringMaxHeightWithContent:(NSString *)content width:(CGFloat)width font:(UIFont *)font;

@end
