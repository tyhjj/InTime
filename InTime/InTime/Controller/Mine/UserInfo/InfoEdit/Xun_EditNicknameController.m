//
//  Xun_EditNicknameController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_EditNicknameController.h"

@interface Xun_EditNicknameController ()
@property (weak, nonatomic) IBOutlet UITextField *nicknameText;

@end

@implementation Xun_EditNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    self.nicknameText.text = self.originalName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"编辑昵称";
    
    [self addLeftBarItem];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark -
#pragma mark Action
- (void)rightBarButtonItemClicked:(id)sender
{
    if ([Xun_Util strNilOrEmpty:self.nicknameText.text]) {
        [MBProgressHUD showError:@"请输入您的昵称之后再提交!"];
    }
    else
    {
        [self startEditUserInfoRequest];
    }
}

#pragma mark -
#pragma mark Request
- (void)startEditUserInfoRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"nick_name" : [Xun_Util strTrim:self.nicknameText.text]
                               };
    
    [MBProgressHUD showMessage:@"正在提交" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppEditUserInfoUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            [MBProgressHUD showSuccess:responseInfo.msg];
            
            if (self.EditSuccessHandler) {
                self.EditSuccessHandler([Xun_Util strTrim:self.nicknameText.text]);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusAutherror])
        {
            [self showLoginViewControllerNeedHideBottomBar:NO];
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
