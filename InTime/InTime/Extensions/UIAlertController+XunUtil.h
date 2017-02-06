//
//  UIAlertController+XunUtil.h
//  AlertViewDemo
//
//  Created by xunsmart on 16/9/29.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertAction+XunAddIndex.h"

@interface UIAlertController (XunUtil)

+ (id)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, copy) void (^AlertControllerActionHandler) (UIAlertAction *action);

@end
