//
//  Xun_RegisterController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RegisterController.h"
#import "Xun_AgreementController.h"

@interface Xun_RegisterController ()
{
    BOOL inv_isAgreed_; //是否同意个人服务协议
    
    //验证码相关
    NSInteger totalTime_;
    NSTimer *timer_;
}

@property (weak, nonatomic) IBOutlet UIView *indivisualView;
@property (weak, nonatomic) IBOutlet UITextField *invUsernameText;
@property (weak, nonatomic) IBOutlet UITextField *invVerifyText;
@property (weak, nonatomic) IBOutlet UIButton *invVerifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *invText;
@property (weak, nonatomic) IBOutlet UITextField *invPwdText;
@property (weak, nonatomic) IBOutlet UIButton *invAgreeBtn;

@end

@implementation Xun_RegisterController

#pragma mark -
#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    [self setUp];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deallocTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"注册";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    [self.invAgreeBtn setImage:[UIImage imageNamed:@"reg_checkN.png"] forState:UIControlStateNormal];
    [self.invAgreeBtn setImage:[UIImage imageNamed:@"reg_checkS.png"] forState:UIControlStateSelected];
}

#pragma mark -
#pragma mark Action
- (IBAction)agreementAction:(id)sender {
    
    if (self.invAgreeBtn.selected == NO) {
        Xun_AgreementController *agreementVC = [[Xun_AgreementController alloc] init];
        agreementVC.IsReadAgreementHandler = ^(BOOL isAgree) {
            self.invAgreeBtn.selected = isAgree;
            inv_isAgreed_ = isAgree;
        };
        
        [self.navigationController pushViewController:agreementVC animated:YES];
    }
    else
    {
        self.invAgreeBtn.selected = !self.invAgreeBtn.selected;
        inv_isAgreed_ = self.invAgreeBtn.selected;
    }
}

- (IBAction)registerAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.invUsernameText.text] ||
        [Xun_Util strNilOrEmpty:self.invVerifyText.text] ||
        [Xun_Util strNilOrEmpty:self.invPwdText.text]) {
        [MBProgressHUD showError:@"输入不能为空!"];
    }
    else if (!inv_isAgreed_)
    {
        [MBProgressHUD showError:@"请阅读并同意《点时贷服务协议》"];
    }
    else
    {
        [self startRegisterRequest];
    }
}

- (IBAction)sendSecCodeAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.invUsernameText.text]) {
        [MBProgressHUD showError:@"请输入手机号码!"];
    }
    else
    {
        //发送验证码请求
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
    self.invVerifyBtn.enabled = NO;
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
        [self.invVerifyBtn setTitle:titleStr forState:UIControlStateNormal];
        totalTime_--;
    }
}

- (void)deallocTimer
{
    self.invVerifyBtn.enabled = YES;
    [self.invVerifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [timer_ invalidate];
    timer_ = nil;
}

#pragma mark -
#pragma mark Request
- (void)startRegisterCodeRequest
{
    NSDictionary *paramDic = @{
                               @"phone" :  [Xun_Util strTrim:self.invUsernameText.text]
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

- (void)startRegisterRequest
{
    NSMutableDictionary *mulDic = [NSMutableDictionary dictionary];
    [mulDic setObject:[Xun_Util strTrim:self.invUsernameText.text] forKey:@"phone"];
    [mulDic setObject:[Xun_Util strTrim:self.invVerifyText.text] forKey:@"captcha"];
    [mulDic setObject:[Xun_Util strTrim:self.invPwdText.text] forKey:@"pwd"];
    
    if (![Xun_Util strNilOrEmpty:self.invText.text]) {
        [mulDic setObject:[Xun_Util strTrim:self.invText.text] forKey:@"captcha1"];
    }
    
    [MBProgressHUD showMessage:@"正在注册" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppIndivisualRegisterUrl] parameters:mulDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
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
