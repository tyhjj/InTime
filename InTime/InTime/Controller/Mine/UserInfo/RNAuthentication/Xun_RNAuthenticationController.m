//
//  Xun_RNAuthenticationController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RNAuthenticationController.h"
#import "Xun_RNAuthenSuccessController.h"

@interface Xun_RNAuthenticationController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *carIDTextField;

@end

@implementation Xun_RNAuthenticationController

#pragma mark -
#pragma mark LifeCycle
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
    self.title = @"实名认证";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)rnAuthenticationAction:(id)sender {
    
    if ([Xun_Util strNilOrEmpty:self.nameTextField.text]) {
        [MBProgressHUD showError:@"请输入真实姓名!"];
    }
    else if ([Xun_Util strNilOrEmpty:self.carIDTextField.text])
    {
        [MBProgressHUD showError:@"请输入身份证号!"];
    }
    else
    {
        [self startAuthenRequest];
    }
    
}

#pragma mark -
#pragma mark Request
- (void)startAuthenRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"realName" : [Xun_Util strTrim:self.nameTextField.text],
                               @"idCard" : [Xun_Util strTrim:self.carIDTextField.text]
                               };
    
    [MBProgressHUD showMessage:@"正在认证" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppRNAuthorUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            Xun_RNAuthenSuccessController *successVC = [[Xun_RNAuthenSuccessController alloc] init];
            successVC.authDic = responseObject;
            [self.navigationController pushViewController:successVC animated:YES];
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
