//
//  Xun_Util.m
//  GlobalTourism
//
//  Created by 王志鹏 on 16/6/20.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：全域旅游
//  功能描述：基础工具类，说明以后在此添加的方法必须是特别通用的方法(就是不论到那个项目都可以使用的)，如果有其他例如关于时间戳计算或者其他的一律使用这个类的扩展添加（保证项目中尽量不出现CommonUtil这样的东西，因为这样的类不论是迁移还是迭代维护特别的费事）,添加的文件例如Xun_Util(NSDate)
//  修改记录
//  王志鹏 2016-6-20   创建该单元

#import "Xun_Util.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@implementation Xun_Util

+ (BOOL)strNilOrEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]]) {
        if (string.length > 0) {
            return NO;
        }
        else {
            return YES;
        }
    }
    else {
        return YES;
    }
}

+ (NSString *)strTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)getServerUrlWithSuffix:(NSString *)suffixUrl
{
    NSAssert(suffixUrl, @"suffix must not be nil");
    return [XunServerUrl stringByAppendingString:suffixUrl];
}

// 弹出系统警告框
+ (UIAlertView *)showAlert:(NSString *)title message:(NSString *)msg
{
    NSString *strAlertOK = @"确定";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:strAlertOK
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}

+ (BOOL)isLogined
{
    if ([Xun_Share sharedInstance].session != nil) {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

+ (void)shareFromController:(id)currentController
{
    //删除微信收藏
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"点时贷" descr:@"一个贴近百姓的金融网络信息平台" thumImage:[UIImage imageNamed:@"appIcon.png"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://www.dianshidai.com.cn";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
     
        //调用分享接口
        [[UMSocialManager defaultManager]
         shareToPlatform:platformType
         messageObject:messageObject
         currentViewController:currentController
         completion:^(id data, NSError *error) {
             if (error) {
                 [MBProgressHUD showError:@"分享失败"];
             }
             else{
                 [MBProgressHUD showSuccess:@"分享完成"];
             }
         }];
    }];
}

@end
