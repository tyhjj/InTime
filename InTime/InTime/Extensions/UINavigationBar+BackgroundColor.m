//
//  UINavigationBar+BackgroundColor.m
//  GlobalTourism
//
//  Created by xunsmart on 16/7/4.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackgroundColor)

static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xun_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
//        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)xun_reset
{
//    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
