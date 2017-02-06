//
//  Xun_ActionSheet.m
//  niuManager
//
//  Created by 王志鹏 on 16/2/25.
//  Copyright © 2016年 XunSmart. All rights reserved.
//
//  系统名称：公共类
//  功能描述：定制PickerView承载视图
//  修改记录
//  王志鹏 2016-2-25   创建该单元

#import "Xun_ActionSheet.h"

@implementation Xun_ActionSheet

@synthesize visible;

-(instancetype)initWithSubview:(UIView *)subview {
    if ([super initWithFrame:subview.frame]) {
        [self addSubview:subview];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void) addView:(UIView *) subview {
    [self setFrame:subview.frame];
    [self addSubview:subview];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)show
{
    self.visible = YES;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (![keyWindow.subviews containsObject:self]) {
        CGRect currentFrame = self.frame; //初始化时的尺寸 初始化时最好为（0，0，宽，高）这个就是从下面弹出的视图的尺寸
        CGRect windowFrame = keyWindow.frame;  //当前屏幕的尺寸
        CGRect newFrame  = CGRectMake(0, windowFrame.size.height-currentFrame.size.height, windowFrame.size.width, currentFrame.size.height); //装有弹出视图的view 将来要动画移动到这个位置
        UIView *overlay = [[UIView alloc] initWithFrame:keyWindow.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6]; //背景视图 这个视图是不变的
        UIView  *bgView = [[UIView alloc] initWithFrame:keyWindow.bounds]; //设置背景颜色的动画 从1.0变到0.5
        [overlay addSubview:bgView];
        [keyWindow addSubview:overlay];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissModalView)];
        overlay.userInteractionEnabled=YES;
        [overlay addGestureRecognizer:tap];
        [UIView animateWithDuration:0.3 animations:^{
            bgView.alpha = 0.5;
        }];
        self.frame = CGRectMake(0, windowFrame.size.height, windowFrame.size.width, currentFrame.size.height); //位置设在最下面（0，屏幕的高，屏幕宽，屏幕高）
        [keyWindow addSubview:self];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.8;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = newFrame;
        }];
    }
}

- (void) dismissModalView
{
    self.visible = NO;
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * modal = [keyWindow.subviews lastObject];
    UIView * overlay = [keyWindow.subviews objectAtIndex:keyWindow.subviews.count-2];
    [UIView animateWithDuration:0.2 animations:^{
        modal.frame = CGRectMake(0, keyWindow.frame.size.height, modal.frame.size.width, modal.frame.size.height);
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
        [modal removeFromSuperview];
    }];
    UIImageView * newView = (UIImageView*)[overlay.subviews objectAtIndex:0];
    [UIView animateWithDuration:0.2 animations:^{
        newView.alpha = 1;
    }];
}

@end
