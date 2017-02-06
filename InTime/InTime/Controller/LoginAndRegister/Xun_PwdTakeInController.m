//
//  Xun_PwdTakeInController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_PwdTakeInController.h"

@interface Xun_PwdTakeInController ()
{
    //验证码相关
    NSInteger totalTime_;
    NSTimer *timer_;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *conFirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *pwdHideBtn;
@property (weak, nonatomic) IBOutlet UIButton *cPwdHideBtn;

@end

@implementation Xun_PwdTakeInController

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

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"找回密码";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)pwdRetakeAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.phoneTextField.text] ||
        [Xun_Util strNilOrEmpty:self.verifyTextField.text] ||
        [Xun_Util strNilOrEmpty:self.pwdTextField.text] ||
        [Xun_Util strNilOrEmpty:self.conFirmPwdTextField.text]) {
        [MBProgressHUD showError:@"输入不能为空!"];
    }
    else if (![[Xun_Util strTrim:self.pwdTextField.text] isEqualToString:[Xun_Util strTrim:self.conFirmPwdTextField.text]])
    {
        [MBProgressHUD showError:@"两次密码输入不一致!"];
    }
    else
    {
        [self startPwdRetakeRequest];
    }
}

- (IBAction)pwdHideAction:(id)sender {
    self.pwdHideBtn.selected = !self.pwdHideBtn.selected;
    
    self.pwdTextField.secureTextEntry = !self.pwdHideBtn.selected;
}

- (IBAction)cPwdHideAction:(id)sender {
    self.cPwdHideBtn.selected = !self.cPwdHideBtn.selected;
    
    self.conFirmPwdTextField.secureTextEntry = !self.cPwdHideBtn.selected;
}

- (IBAction)sendVerifyCodeAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.phoneTextField.text]) {
        [MBProgressHUD showError:@"请输入手机号码!"];
    }
    else
    {
        [self startRegisterCodeRequest];
        
        [self startTimer];
    }
}

#pragma mark -
#pragma mark Timer
- (void)startTimer
{
    timer_ = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    //设置下次发送总时间
    totalTime_ = 60;
    //设置按钮不可点击
    self.verifyBtn.enabled = NO;
}

- (void)updateTimer:(NSTimer *)timer
{
    if (totalTime_ == 0) {
        //销毁计时器
        [self deallocTimer];
    }
    else
    {
        NSString *titleStr = [NSString stringWithFormat:@"%lds重发", (long)totalTime_];
        [self.verifyBtn setTitle:titleStr forState:UIControlStateNormal];
        totalTime_--;
    }
}

- (void)deallocTimer
{
    self.verifyBtn.enabled = YES;
    [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [timer_ invalidate];
    timer_ = nil;
}

#pragma mark -
#pragma mark Request
- (void)startRegisterCodeRequest
{
    NSDictionary *paramDic = @{
                               @"phone" :  [Xun_Util strTrim:self.phoneTextField.text]
                               };
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppVerifyCodeUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:responseInfo.msg];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
            [self deallocTimer];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:[error localizedDescription]];
        [self deallocTimer];
    }];
}

- (void)startPwdRetakeRequest
{
    NSDictionary *paramDic = @{
                               @"phone" : [Xun_Util strTrim:self.phoneTextField.text],
                               @"captcha" : [Xun_Util strTrim:self.verifyTextField.text],
                               @"pwd" : [Xun_Util strTrim:self.pwdTextField.text],
                               @"pwd2" : [Xun_Util strTrim:self.conFirmPwdTextField.text]
                               };
    
    [MBProgressHUD showMessage:@"正在修改" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppPwdTakeInUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:responseInfo.msg];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
    }];
}

@end
