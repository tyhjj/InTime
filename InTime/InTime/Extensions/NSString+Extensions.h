//
//  NSString+Extensions.h
//  niuManager
//
//  Created by 王志鹏 on 16/3/3.
//  Copyright © 2016年 wenpeifang. All rights reserved.
//
//  系统名称：不限
//  功能描述：NSString扩展类
//  修改记录
//  王志鹏 2016-3-3   创建该单元

@interface NSString (Extensions)

/**
 *  移除收尾空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trim;

/**
 *  空字符串
 *
 *  @return 空字符串
 */
+ (NSString *)empty;

/**
 *  md5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5;

/**
 *  url转码
 *
 *  @return 转码之后的urlString
 */
- (NSString *)urlEncoded;

@end
