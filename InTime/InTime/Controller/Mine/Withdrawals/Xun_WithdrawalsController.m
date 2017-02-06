//
//  Xun_WithdrawalsController.m
//  InTime
//
//  Created by xunsmart on 2017/1/16.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_WithdrawalsController.h"
#import "Xun_WithdrawalsSuccessViewController.h"

@interface Xun_WithdrawalsController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankLogo;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UITextField *withdrawalsTextfield;
@property (weak, nonatomic) IBOutlet UILabel *feesLabel;

@end

@implementation Xun_WithdrawalsController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([Xun_Util strNilOrEmpty:self.balance]) {
        self.balanceLabel.text = @"暂时无法获取";
    }
    else
    {
        self.balanceLabel.text = [NSString stringWithFormat:@"%.2f元", [self.balance floatValue]];
    }
    
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
    self.title = @"申请提现";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)selectBankAction:(id)sender {
    
}

- (IBAction)withdrawalsAction:(id)sender {
    Xun_WithdrawalsSuccessViewController *successVC = [[Xun_WithdrawalsSuccessViewController alloc] init];
    [self.navigationController pushViewController:successVC animated:YES];
}

@end
