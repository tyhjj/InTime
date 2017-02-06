//
//  Xun_Share.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/7/11.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：公共类
//  功能描述：全局单例对象
//  修改记录
//  王志鹏 2016-7-11   创建该单元

#import "Xun_Share.h"

@implementation Xun_Share

+ (Xun_Share *)sharedInstance
{
    static Xun_Share *_instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        
                      _instance  = [[Xun_Share myAlloc] init
                                         ];
                  }
    );
    
    return _instance;
}

+ (instancetype)myAlloc
{
    return [super allocWithZone:nil];
}

+ (instancetype)alloc
{
    //不允许使用类工厂方法创建实例了
    return nil;
}


+ (instancetype)new
{
    return [self alloc];
}

+ (instancetype)allocWithZone:(NSZone*)zone
{
    return [self alloc];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    // -copy inherited from NSObject calls -copyWithZone:
    return self;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    // -mutableCopy inherited from NSObject calls -mutableCopyWithZone:
    return [self copyWithZone:zone];
}

@end
