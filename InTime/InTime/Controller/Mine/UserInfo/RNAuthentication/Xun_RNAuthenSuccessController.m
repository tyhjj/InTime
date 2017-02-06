//
//  Xun_RNAuthenSuccessController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RNAuthenSuccessController.h"

@interface Xun_RNAuthenSuccessController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardIDLabel;

@end

@implementation Xun_RNAuthenSuccessController

#pragma mark -
#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    self.nameLabel.text = [NSString stringWithFormat:@"真实姓名：%@", self.authDic[@"realName"]];
    self.cardIDLabel.text = [NSString stringWithFormat:@"身份证号：%@", self.authDic[@"idCard"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"实名认证";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)investmentAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
