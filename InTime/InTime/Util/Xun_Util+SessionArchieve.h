//
//  Xun_Util+SessionArchieve.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/7/11.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：Session归档工具类
//  修改记录
//  王志鹏 2016-7-11   创建该单元

#import "Xun_Util.h"

@interface Xun_Util (SessionArchieve)

/**
 *  归档Session
 *
 *  @param session session
 */
+ (void)archieveUserSession:(Xun_Session *)session;

/**
 *  解档Session
 *
 *  @return session
 */
+ (Xun_Session *)unarchieveUserSession;

/**
 *  移除Session
 */
+ (void)removeUserSession;

@end
