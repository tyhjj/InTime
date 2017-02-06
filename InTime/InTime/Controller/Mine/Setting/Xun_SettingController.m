//
//  Xun_SettingController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SettingController.h"
#import "Xun_AboutController.h"
#import "Xun_FeedbackController.h"
#import "Xun_MessageController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface Xun_SettingController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray_;
}

@property (weak, nonatomic) IBOutlet UITableView *settingTableVIew;

@end

@implementation Xun_SettingController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageStatusChanged:) name:Xun_MessageStatusChangeNotification object:nil];
    
    [self setNavigation];
    
    [self initTableViewDataSource];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Xun_MessageStatusChangeNotification object:nil];
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"设置";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    self.settingTableVIew.sectionHeaderHeight = 10.0f;
}

#pragma mark -
#pragma mark InitTableViewDataSource
- (void)initTableViewDataSource
{
    titleArray_ = @[
                    @[
                        @"消息中心",
                        @"意见反馈"
                        ],
                    @[
                        @"推荐好友",
                        @"关于我们",
                        @"客服电话"
                        ]
                    ];
}

#pragma mark -
#pragma mark Action
- (void)messageStatusChanged:(NSNotification *)notify
{
    self.isHaveMessage = [NSString stringWithFormat:@"%d", ![notify.object boolValue]];
    
    [self.settingTableVIew reloadData];
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray_[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deqCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"deqCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = titleArray_[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.detailTextLabel.textColor = [UIColor redColor];
        if (![Xun_Util strNilOrEmpty:self.isHaveMessage] && [self.isHaveMessage isEqualToString:@"1"]) {
            cell.detailTextLabel.text = @"∙";
        }
        else
        {
            cell.detailTextLabel.text = @"";
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        cell.detailTextLabel.text = Xun_AppContactPhoneNumber;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 10);
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (![Xun_Util isLogined]) {
            [MBProgressHUD showError:@"请登录之后再评价"];
        }
        else
        {
            Xun_MessageController *messageVC = [[Xun_MessageController alloc] init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        if (![Xun_Util isLogined]) {
            [MBProgressHUD showError:@"请登录之后再评价"];
        }
        else
        {
            Xun_FeedbackController *feedbackVC = [[Xun_FeedbackController alloc] init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        [Xun_Util shareFromController:nil];
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        Xun_AboutController *aboutVC = [[Xun_AboutController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", Xun_AppContactPhoneNumber]]];
    }
}

@end
