//
//  MBProgressHUD+Xun.h
//  niuManager
//
//  Created by xunsmart on 16/3/23.
//  Copyright © 2016年 wenpeifang. All rights reserved.
//

#import "MBProgressHUD+JM.h"

@interface MBProgressHUD (Xun)
+ (void)showMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)delay;
+ (void)showMessage:(NSString *)message toView:(UIView *)view andHideAfterDelay:(NSTimeInterval)delay;
+ (void)mbp_hideHUD:(id)obj;

@end
