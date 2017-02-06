//
//  Xun_MineController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_MineController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "Xun_MineHeaderView.h"
#import "Xun_SettingController.h"
#import "Xun_LoginController.h"
#import "Xun_UserInfoController.h"
#import "Xun_TradeRecordController.h"
#import "Xun_FinacingManagerController.h"
#import "Xun_CommissionController.h"
#import "Xun_RechargeController.h"
#import "Xun_WithdrawalsController.h"

@interface Xun_MineController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *itemArr_;
    
    UIImageView *avatarImage_;
    UILabel *nameLabel_;
}

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) Xun_MineHeaderView *headerView;
@property (nonatomic, copy) NSString *isHaveMessage;
@property (nonatomic, copy) NSString *balance;

@end

@implementation Xun_MineController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNotification:) name:Xun_LoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:Xun_LogoutNotification object:nil];
    
    [self setNavigation];
    
    [self initTableDatasource];
    
    if ([Xun_Util isLogined]) {
        [self startMineRequest];
    }
    else
    {
        [self updateLeftBarItemWithJson:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = Xun_BaseBlueColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barTintColor = Xun_ColorRGB(252, 252, 252);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Xun_LoginSuccessNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:Xun_LogoutNotification object:nil];
}

- (void)viewDidLayoutSubviews
{
    [self setUp];
}

#pragma makr -
#pragma mark AboutUI
- (void)setNavigation
{
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:[self barCustomView]];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_top_setting.png"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction:)];
    rightBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)setUp
{
    self.menuTableView.tableHeaderView = self.headerView;
    self.menuTableView.sectionHeaderHeight = 20.0f;
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (![Xun_Util isLogined]) {
            [self.menuTableView.mj_header endRefreshing];
        }
        else
        {
            [self startMineRequest];
        }
    }];
    [gifHeader setImages:@[[UIImage imageNamed:@"login_logo.png"]] forState:MJRefreshStateIdle];
    self.menuTableView.mj_header = gifHeader;
}

- (Xun_MineHeaderView *)headerView
{
    if (_headerView == nil) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Xun_MineHeaderView" owner:nil options:nil];
        _headerView = [nibContents lastObject];
        _headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 200);
    }
    return _headerView;
}

- (UIView *)barCustomView
{
    UIView *customView = [[UIView alloc] init];
    customView.frame = CGRectMake(0, 0, 200, 40);
    
    avatarImage_ = [UIImageView new];
    avatarImage_.frame = CGRectMake(0, 0, 40, 40);
    avatarImage_.layer.cornerRadius = avatarImage_.width / 2.0;
    avatarImage_.clipsToBounds = YES;
//    avatarImage_.image = [UIImage imageNamed:@"mine_defaultAvatar.png"];
    [customView addSubview:avatarImage_];
    
    nameLabel_ = [UILabel new];
    nameLabel_.frame = CGRectMake(avatarImage_.right + 5, 0, 150, 20);
    nameLabel_.centerY = customView.height / 2.0;
    nameLabel_.textColor = [UIColor whiteColor];
//    nameLabel_.text = @"123456789";
    [customView addSubview:nameLabel_];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImageDidTapped:)];
    [customView addGestureRecognizer:tapGes];
    
    return customView;
}

- (void)updateLeftBarItemWithJson:(NSDictionary *)json
{
    if ([Xun_Util isLogined] && json != nil) {
        //如果登录了，更新头像
        [avatarImage_ sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", json[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"mine_defaultAvatar.png"]];
        nameLabel_.text = [NSString stringWithFormat:@"%@", json[@"name"]];
        self.headerView.balanceLabel.text = [NSString stringWithFormat:@"%.2f", [json[@"total"] floatValue]];
        self.headerView.yesIncomLabel.text = [NSString stringWithFormat:@"昨日收益:%.2f", [json[@"income"] floatValue]];
        self.headerView.totalIncomLabel.text = [NSString stringWithFormat:@"累计收益:%.2f", [json[@"income"] floatValue]];
    }
    else
    {
        avatarImage_.image = [UIImage imageNamed:@"mine_defaultAvatar.png"];
        nameLabel_.text = @"登录";
        self.headerView.balanceLabel.text = [NSString stringWithFormat:@"%.2f", 0.00];
        self.headerView.yesIncomLabel.text = [NSString stringWithFormat:@"昨日收益:%.2f", 0.00];
        self.headerView.totalIncomLabel.text = [NSString stringWithFormat:@"累计收益:%.2f", 0.00];
    }
}

#pragma mark -
#pragma mark InitTableDataSource
- (void)initTableDatasource
{
    itemArr_ = @[
                 @{@"title" : @"交易记录", @"icon" : @"top_menu_log.png"},
//                 @{@"title" : @"提现余额", @"icon" : @"top_menu_withdraw.png"},
                 @{@"title" : @"充值金额", @"icon" : @"top_menu_charge.png"},
                 @{@"title" : @"理财管理", @"icon" : @"top_menu_financing.png"},
//                 @{@"title" : @"我的提成", @"icon" : @"top_menu_push.png"}
                 ];
}

#pragma mark -
#pragma mark Action 
- (void)settingAction:(id)sender
{
    if (sender == self.navigationItem.rightBarButtonItem) {
        Xun_SettingController *settingVC = [[Xun_SettingController alloc] init];
        if (![Xun_Util strNilOrEmpty:self.isHaveMessage]) {
            settingVC.isHaveMessage = self.isHaveMessage;
        }
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

- (void)avatarImageDidTapped:(UITapGestureRecognizer *)tapGes
{
    if (![Xun_Util isLogined]) {
        //如果没登录
        Xun_LoginController *loginVC = [[Xun_LoginController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else
    {
        Xun_UserInfoController *userInfoVC = [[Xun_UserInfoController alloc] init];
        userInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
}

- (void)loginSuccessNotification:(NSNotification *)notify
{
    //登录成功通知
    [self startMineRequest];
}

- (void)logoutNotification:(NSNotification *)notify
{
    [self updateLeftBarItemWithJson:nil];
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
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deqCell"];
        
        if (indexPath.row == 0) {
            UILabel *topLine = [UILabel new];
            topLine.frame = CGRectMake(0, 0, kXunScreenWidth, 0.5);
            topLine.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:topLine];
        }
        
        UILabel *line = [UILabel new];
        line.frame = CGRectMake(20, cell.contentView.height - 0.5, kXunScreenWidth - 20 * 2, 0.5);
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
        
        if (indexPath.row == itemArr_.count - 1) {
            line.x = 0;
            line.width = kXunScreenWidth;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = itemArr_[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:itemArr_[indexPath.row][@"icon"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kXunScreenWidth, 20);
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![Xun_Util isLogined]) {
        Xun_LoginController *loginVC = [[Xun_LoginController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else
    {
        if (indexPath.row == 0) {
            Xun_TradeRecordController *tradeVC = [[Xun_TradeRecordController alloc] init];
            tradeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tradeVC animated:YES];
        }
        /*
        else if (indexPath.row == 1)
        {
            Xun_WithdrawalsController *withdrawalsVC = [[Xun_WithdrawalsController alloc] init];
            if (![Xun_Util strNilOrEmpty:self.balance]) {
                withdrawalsVC.balance = self.balance;
            }
            withdrawalsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:withdrawalsVC animated:YES];
        }
         */
        else if (indexPath.row == 1)
        {
            Xun_RechargeController *rechargeVC = [[Xun_RechargeController alloc] init];
            if (![Xun_Util strNilOrEmpty:self.balance]) {
                rechargeVC.balance = self.balance;
            }
            rechargeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }
        else if (indexPath.row == 2)
        {
            Xun_FinacingManagerController *finacingVC = [[Xun_FinacingManagerController alloc] init];
            finacingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:finacingVC animated:YES];
        }
        /*
        else if (indexPath.row == 4)
        {
            Xun_CommissionController *commissionVC = [[Xun_CommissionController alloc] init];
            commissionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:commissionVC animated:YES];
        }
         */
    }
}

#pragma mark -
#pragma mark Request
- (void)startMineRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在获取" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppMineUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            self.isHaveMessage = [NSString stringWithFormat:@"%@", responseObject[@"announcement"]];
            self.balance = [NSString stringWithFormat:@"%@", responseObject[@"total"]];
            [self updateLeftBarItemWithJson:responseObject];
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusAutherror])
        {
            [MBProgressHUD showError:responseInfo.msg];
            [Xun_Share sharedInstance].session = nil;
            [Xun_Util removeUserSession];
            [self updateLeftBarItemWithJson:nil];
            [self showLoginViewControllerNeedHideBottomBar:YES];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
        [self.menuTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:[error localizedDescription]];
        
        [self.menuTableView.mj_header endRefreshing];
        
    }];
}

@end
