//
//  MBProgressHUD+Xun.m
//  niuManager
//
//  Created by xunsmart on 16/3/23.
//  Copyright © 2016年 wenpeifang. All rights reserved.
//

#import "MBProgressHUD+Xun.h"

@implementation MBProgressHUD (Xun)
+ (void)showMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)delay
{
    [self showMessage:message toView:nil];
    [self performSelector:@selector(mbp_hideHUD:) withObject:nil afterDelay:delay];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view andHideAfterDelay:(NSTimeInterval)delay
{
    [self showMessage:message toView:view];
    [self performSelector:@selector(mbp_hideHUD:) withObject:view afterDelay:delay];
}

+ (void)mbp_hideHUD:(id)obj
{
    UIView *view = obj;
    
    [MBProgressHUD hideHUDForView:view];
}

@end
