//
//  Xun_Util+HTTPRequest.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/21.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：网络请求工具类
//  修改记录
//  王志鹏 2016-6-21   创建该单元

#import "Xun_Util.h"
#import "Xun_ResponseInfo.h"

@interface Xun_Util (HTTPRequest)

/**
 *  GET网络请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**
 *  POST网络请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

@end
