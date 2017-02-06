//
//  Xun_BaseDefine.h
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：所有项目
//  功能描述：宏定义类
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#ifndef Xun_BaseDefine_h
#define Xun_BaseDefine_h

//是否是发布版本(发布版本设置这个值为1，测试版本设置这个值为0)
#define isRelease 0
//debug记录   测试环境
#if isRelease == 0
#define Xun_DebugLog(message,...) NSLog((@"%s [Line %d]" message),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
//debug记录   发布环境
#elif isRelease == 1
#define Xun_DebugLog(message,...)
#endif

#if isRelease == 0
//测试服务器地址
#define XunServerUrl @"http://www.dianshidai.com.cn/api.php?"
//发布环境地址
#elif isRelease == 1
#define XunServerUrl @"http://www.dianshidai.com.cn/api.php?"
#endif

/**
 *  获取屏幕宽高
 */
#define kXunScreenWidth [UIScreen mainScreen].bounds.size.width
#define kXunScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 *  设置颜色
 */
#define Xun_ColorRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define Xun_ColorRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define Xun_ColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

/**
 *  网络请求成功之后状态码
 */
#define Xun_RequestStatusSuccess @"success"
#define Xun_RequestStatusFailer @"error"
#define Xun_RequestStatusAutherror @"autherror"
#define Xun_RequestStatusRNAuthNone @"rnauthNone"

/**
 *  网络超时时间
 */
#define Xun_TimeOut 30.0f

/*
 *NSUserDefaults 本地保存所需关键字
 */
#define USERDEFAULT          [NSUserDefaults standardUserDefaults]

//#333333 导航
#define NavigationWordColor       Xun_ColorFromHex(0x333333)
//#666666 标题
#define TitleWordColor            Xun_ColorFromHex(0x666666)
//#999999 内文
#define ContentWordColor          Xun_ColorFromHex(0x999999)

//基础蓝色
#define Xun_BaseBlueColor   Xun_ColorFromHex(0x4A4F9D)


#define Xun_AlertMessage_Trim @"输入不能为空!"

#define Xun_AppContactPhoneNumber @"13718782964"

/*
 Share
 */
#define UMengShareKey @"58801874ae1bf8211d000a82"
#define QQAppID @"1105883139"
#define QQAppKey @"HkxGLx1akTJXiPhU"
#define WechatAppID @"wx131c2544419c8700"
#define WechatAppSecret @"bbcf05eefabae4229bfc9eb56b6a5274"


typedef enum : NSUInteger {
    Xun_TableStateRefresh,
    Xun_TableStateLoadMore,
} Xun_TableRefreshState;



#endif /* Xun_BaseDefine_h */
