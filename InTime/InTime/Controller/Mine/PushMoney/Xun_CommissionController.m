//
//  Xun_CommissionController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_CommissionController.h"

@interface Xun_CommissionController ()

@end

@implementation Xun_CommissionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"我的提成";
    
    [self addLeftBarItem];
}

@end
