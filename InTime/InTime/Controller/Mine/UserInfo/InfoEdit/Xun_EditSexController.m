//
//  Xun_EditSexController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_EditSexController.h"

@interface Xun_EditSexController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *itemArr_;
}

@property (weak, nonatomic) IBOutlet UITableView *sexTableView;

@end

@implementation Xun_EditSexController

#pragma mark -
#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    itemArr_ = @[
                 @"男",
                 @"女"
                 ];
    
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if (self.selectSex > 0) {
        UITableViewCell *cell = [self.sexTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(self.selectSex - 1) inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"编辑性别";
    
    [self addLeftBarItem];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemArr_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deqCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deqCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            UILabel *line = [UILabel new];
            line.frame = CGRectMake(0, cell.contentView.height - 0.5, kXunScreenWidth, 0.5);
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
        }
    }
    
    cell.textLabel.text = itemArr_[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (unsigned i = 0; i < itemArr_.count; i++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.selectSex = indexPath.row + 1;
}

#pragma mark -
#pragma mark Action 
- (void)rightBarItemClicked:(id)sender
{
    if (self.selectSex == 0) {
        [MBProgressHUD showError:@"请选择性别!"];
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
                               @"sex" : @(self.selectSex)
                               };
    
    [MBProgressHUD showMessage:@"正在提交" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppEditUserInfoUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            
            [MBProgressHUD showSuccess:responseInfo.msg];
            
            if (self.EditSuccessHandler) {
                self.EditSuccessHandler(@(self.selectSex));
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
