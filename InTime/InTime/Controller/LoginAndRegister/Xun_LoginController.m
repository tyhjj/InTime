//
//  Xun_LoginController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_LoginController.h"
#import "Xun_PwdTakeInController.h"
#import "Xun_RegisterController.h"

@interface Xun_LoginController ()
{
    BOOL isRememberPwd_;
}

@property (weak, nonatomic) IBOutlet UIButton *remPwdBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *hidePwdBtn;

@end

@implementation Xun_LoginController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"登录";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    [self.remPwdBtn setImage:[UIImage imageNamed:@"login_checkN.png"] forState:UIControlStateNormal];
    [self.remPwdBtn setImage:[UIImage imageNamed:@"login_checkS.png"] forState:UIControlStateSelected];
}
#pragma mark -
#pragma mark Action
- (IBAction)rememberPwdAction:(id)sender {
    
    self.remPwdBtn.selected = !self.remPwdBtn.selected;
    
    isRememberPwd_ = self.remPwdBtn.selected;
}

- (IBAction)forgetPwdAction:(id)sender {
    Xun_PwdTakeInController *pwdTakeInVC = [[Xun_PwdTakeInController alloc] init];
    [self.navigationController pushViewController:pwdTakeInVC animated:YES];
}

- (IBAction)loginAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.usernameTextField.text] ||
        [Xun_Util strNilOrEmpty:self.pwdTextField.text]) {
        [MBProgressHUD showError:@"输入不能为空!"];
    }
    else
    {
        [self startLoginRequest];
    }
}

- (IBAction)registerAction:(id)sender {
    Xun_RegisterController *registerVC = [[Xun_RegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)hidePwdAction:(id)sender {
    self.hidePwdBtn.selected = !self.hidePwdBtn.selected;
    
    self.pwdTextField.secureTextEntry = !self.hidePwdBtn.selected;
}

#pragma mark -
#pragma mark Request
- (void)startLoginRequest
{
    NSDictionary *paramDic = @{
                               @"name" : [Xun_Util strTrim:self.usernameTextField.text],
                               @"password" : [Xun_Util strTrim:self.pwdTextField.text]
                               };
    
    [MBProgressHUD showMessage:@"正在登录" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppLoginUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            
            Xun_Session *session = [[Xun_Session alloc] initWithJsonDic:responseObject];
            [Xun_Share sharedInstance].session = session;
            
            if (isRememberPwd_) {
                [Xun_Util archieveUserSession:[Xun_Share sharedInstance].session];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:Xun_LoginSuccessNotification object:nil];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
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
