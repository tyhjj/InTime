//
//  Xun_Util+HTTPRequest.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/21.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：网络请求工具类
//  修改记录
//  王志鹏 2016-6-21   创建该单元

#import "Xun_Util+HTTPRequest.h"

@implementation Xun_Util (HTTPRequest)

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    
    [httpManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        if (resultDic) {
            Xun_ResponseInfo *respInfo = [[Xun_ResponseInfo alloc] initWithJsonDic:resultDic];
            id dataObject = [resultDic objectForKey:@"data"];
            if (success) {
                success(task, dataObject, respInfo);
            }
        }
        else
        {
            Xun_ResponseInfo *respInfo = [[Xun_ResponseInfo alloc] init];
            respInfo.status = @"9999";
            respInfo.msg = @"无返回数据";
            if (success) {
                success(task, nil, respInfo);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    
    [httpManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultDic = responseObject;
        
        if (resultDic) {
            Xun_ResponseInfo *respInfo = [[Xun_ResponseInfo alloc] initWithJsonDic:resultDic];
            id dataObject = [resultDic objectForKey:@"data"];
            if (success) {
                success(task, dataObject, respInfo);
            }
        }
        else
        {
            Xun_ResponseInfo *respInfo = [[Xun_ResponseInfo alloc] init];
            respInfo.status = @"9999";
            respInfo.msg = @"无返回数据";
            if (success) {
                success(task, nil, respInfo);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
        
    }];
}

@end
