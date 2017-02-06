//
//  UIAlertController+XunUtil.m
//  AlertViewDemo
//
//  Created by xunsmart on 16/9/29.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "UIAlertController+XunUtil.h"
#import <objc/runtime.h>

static char kXunAlertActionHandlerKey = '\0';

@implementation UIAlertController (XunUtil)

+ (id)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    NSUInteger buttonIndex = 0;
    
    if (destructiveButtonTitle != nil) {
        UIAlertAction *desAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.AlertControllerActionHandler) {
                alertController.AlertControllerActionHandler(action);
            }
        }];
        desAction.buttonIndex = buttonIndex++;
        [alertController addAction:desAction];
    }
    
    NSMutableArray* otherButtons = [NSMutableArray array];
    
    va_list argList;
    
    if(otherButtonTitles){
        
        [otherButtons addObject:otherButtonTitles];
        
        va_start(argList, otherButtonTitles);
        
        id arg;
        
        while ((arg = va_arg(argList, id))) {
            [otherButtons addObject:arg];
        }
    }
    va_end(argList);
    
    for (NSString *otherButtonTitle in otherButtons) {
        if (otherButtonTitle == nil) {
            continue ;
        }
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.AlertControllerActionHandler) {
                alertController.AlertControllerActionHandler(action);
            }
        }];
        otherAction.buttonIndex = buttonIndex++;
        [alertController addAction:otherAction];
    }
    
    if (cancelButtonTitle != nil) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.AlertControllerActionHandler) {
                alertController.AlertControllerActionHandler(action);
            }
        }];
        cancelAction.buttonIndex = buttonIndex;
        [alertController addAction:cancelAction];
    }
    
    return alertController;
}

- (void)setAlertControllerActionHandler:(void (^)(UIAlertAction *))AlertControllerActionHandler
{
    objc_setAssociatedObject(self, &kXunAlertActionHandlerKey, AlertControllerActionHandler, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIAlertAction *))AlertControllerActionHandler
{
    void (^AlertActionHandler)(UIAlertAction *) = objc_getAssociatedObject(self, &kXunAlertActionHandlerKey);
    
    return AlertActionHandler;
}

@end
