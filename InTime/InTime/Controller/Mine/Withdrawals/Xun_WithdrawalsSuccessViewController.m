//
//  Xun_WithdrawalsSuccessViewController.m
//  InTime
//
//  Created by xunsmart on 2017/1/16.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_WithdrawalsSuccessViewController.h"

@interface Xun_WithdrawalsSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *bankInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *feesLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation Xun_WithdrawalsSuccessViewController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    self.contentBgView.layer.cornerRadius = 5.0f;
}


#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"申请提现";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)showTradeRecordsAction:(id)sender {
}

@end
