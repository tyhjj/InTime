//
//  Xun_Share.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/7/11.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：公共类
//  功能描述：全局单例对象
//  修改记录
//  王志鹏 2016-7-11   创建该单元

#import <Foundation/Foundation.h>

@interface Xun_Share : NSObject

@property (nonatomic, strong) Xun_Session *session;

/**
 *  单例对象
 *
 *  @return 单例对象
 */
+ (Xun_Share *)sharedInstance;

@end
