//
//  Xun_Util.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：基础工具类，说明以后在此添加特别通用的方法，如果有其他例如关于时间戳计算或者其他的一律使用这个类的扩展添加（保证项目中尽量不出现CommonUtil这样的东西）,添加的文件例如Xun_Util(NSDate)
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#import <Foundation/Foundation.h>

@interface Xun_Util : NSObject

/**
 *  判断字符串是否是空
 *
 *  @param string 要判断的字符串
 *
 *  @return 返回的判断结果
 */
+ (BOOL)strNilOrEmpty:(NSString *)string;

/**
 *  去掉字符串两端的空格
 *
 *  @param string 要处理的字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)strTrim:(NSString *)string;

/**
 *  根据接口后缀获取接口详细地址
 *
 *  @param suffixUrl 接口后缀
 *
 *  @return 接口详细地址
 */
+ (NSString *)getServerUrlWithSuffix:(NSString *)suffixUrl;

/**
 *  弹出系统弹出框
 *
 *  @param title 标题
 *  @param msg   内容
 *
 *  @return 弹出框
 */
+ (UIAlertView *)showAlert:(NSString *)title message:(NSString *)msg;


/**
 是否登录

 @return 登录结果
 */
+ (BOOL)isLogined;


/**
 获取App版本

 @return App版本信息
 */
+ (NSString *)getAppVersion;



/**
 分享

 @param currentController 当前的Controller
 */
+ (void)shareFromController:(id)currentController;

@end
