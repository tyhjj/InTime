//
//  Xun_FeedbackController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_FeedbackController.h"
//#import "IQTextView.h"

@interface Xun_FeedbackController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation Xun_FeedbackController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
//    self.textView.placeholder = @"请输入您遇到的问题或想法、建议（字数150字以内）";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"意见反馈";
    
    [self addLeftBarItem];
}

#pragma mark -
#pragma mark Action
- (IBAction)submitAction:(id)sender {
    if ([Xun_Util strNilOrEmpty:self.textView.text]) {
        [MBProgressHUD showError:@"请输入您的问题或想法!"];
    }
    else if ([Xun_Util strNilOrEmpty:self.textField.text])
    {
        [MBProgressHUD showError:@"请输入您的手机号或邮箱!"];
    }
    else
    {
        [self startFeedbackRequest];
    }
}

#pragma mark -
#pragma mark Request
- (void)startFeedbackRequest
{
    NSDictionary *paramDic = @{
                               @"content" : [Xun_Util strTrim:self.textView.text],
                               @"contact" : [Xun_Util strTrim:self.textField.text]
                               };
    
    [MBProgressHUD showMessage:@"正在提交" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppFeedbackUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
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
