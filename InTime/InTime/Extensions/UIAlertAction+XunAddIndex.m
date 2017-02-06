//
//  UIAlertAction+XunAddIndex.m
//  AlertViewDemo
//
//  Created by xunsmart on 16/9/29.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "UIAlertAction+XunAddIndex.h"
#import <objc/runtime.h>

static char kXunUIAlertActionButtonIndexKey = '\0';

@implementation UIAlertAction (XunAddIndex)

@dynamic buttonIndex;

- (NSUInteger)buttonIndex
{
    return [objc_getAssociatedObject(self, &kXunUIAlertActionButtonIndexKey) unsignedIntegerValue];
}

- (void)setButtonIndex:(NSUInteger)buttonIndex
{
    objc_setAssociatedObject(self, &kXunUIAlertActionButtonIndexKey, @(buttonIndex), OBJC_ASSOCIATION_RETAIN);
}

@end
