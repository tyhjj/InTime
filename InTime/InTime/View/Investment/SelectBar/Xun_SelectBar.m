//
//  Xun_SelectBar.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SelectBar.h"

@interface Xun_SelectBar ()
{
    UILabel *barLabel_;
}

@property (nonatomic, strong) NSArray *items;

@end

@implementation Xun_SelectBar

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        self.items = items;
        [self createItem];
    }
    return self;
}

- (void)createItem
{
    if (self.subviews > 0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat buttonWidth = self.width / self.items.count;
    CGFloat buttonHeight = self.height;
    CGFloat centerX = 0;
    for (unsigned int i = 0; i < self.items.count; i++) {
        UIButton *button = [self createBtn];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        button.tag = i;
        [button setTitle:self.items[i] forState:UIControlStateNormal];
        [self addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            centerX = button.centerX;
        }
    }
    
    barLabel_ = [UILabel new];
    barLabel_.frame = CGRectMake(0, self.height - 2, buttonWidth - 20, 2);
    barLabel_.backgroundColor = Xun_BaseBlueColor;
    barLabel_.centerX = centerX;
    [self addSubview:barLabel_];
}

- (UIButton *)createBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:Xun_ColorFromHex(0x333333) forState:UIControlStateNormal];
    [button setTitleColor:Xun_BaseBlueColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -
#pragma mark Action
- (void)buttonClicked:(UIButton *)button
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            button.selected = NO;
        }
    }
    
    button.selected = YES;
    barLabel_.centerX = button.centerX;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectBarAtIndex:)]) {
        [self.delegate didSelectBarAtIndex:button.tag];
    }
}

@end
