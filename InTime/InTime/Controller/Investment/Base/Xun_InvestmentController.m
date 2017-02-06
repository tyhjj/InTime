//
//  Xun_InvestmentController.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_InvestmentController.h"
#import "DXPopover.h"
#import "Xun_FinacingCell.h"
#import "Xun_InvestmentDetailController.h"

@interface Xun_InvestmentController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *fromInvArray_;
    NSArray *termArray_;
    NSArray *rateArray_;
    
    NSInteger selectBtnIndex_;
    
    Xun_TableRefreshState refreshState_;
    NSUInteger pageNum_;
    
    NSInteger fromInvState_;
    NSInteger termState_;
    NSInteger rateState_;
    
    NSMutableArray *proArr_;
}

@property (weak, nonatomic) IBOutlet UITableView *proTableView;
@property (nonatomic, strong) UITableView *siftTableView;
@property (weak, nonatomic) IBOutlet UIButton *fromInvBtn;
@property (weak, nonatomic) IBOutlet UIButton *termBtn;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn;
@property (nonatomic, strong) DXPopover *popoverView;

@end

@implementation Xun_InvestmentController

#pragma mark -
#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投资";
    
    [self initDataSource];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Property Getter && Setter
- (UITableView *)siftTableView
{
    if (_siftTableView == nil) {
        _siftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kXunScreenWidth / 3.0, 150) style:UITableViewStylePlain];
        _siftTableView.delegate = self;
        _siftTableView.dataSource = self;
    }
    return _siftTableView;
}

- (DXPopover *)popoverView
{
    if (_popoverView == nil) {
        _popoverView = [DXPopover new];
        _popoverView.width = kXunScreenWidth / 3.0;
    }
    return _popoverView;
}

#pragma mark -
#pragma mark InitDataSource
- (void)initDataSource
{
    fromInvArray_ = @[
                      @"不限",
                      @"￥100元以下",
                      @"￥1,000-￥50,000 ",
                      @"￥50,000~￥200,000",
                      @"￥200,000以上"
                      ];
    termArray_ = @[
                      @"不限",
                      @"3个月以内",
                      @"3-6个月",
                      @"6-12个月",
                      @"12个月以上"
                      ];
    rateArray_ = @[
                   @"不限",
                   @"10%以下",
                   @"10%-16%",
                   @"16%以上"
                   ];
    
    proArr_ = [NSMutableArray array];
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    [self.proTableView registerNib:[UINib nibWithNibName:@"Xun_FinacingCell" bundle:nil] forCellReuseIdentifier:@"finacingCell"];
    
    self.proTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNum_ = 1;
        refreshState_ = Xun_TableStateRefresh;
        [self startMineRequest];
    }];
    self.proTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        pageNum_ ++;
        refreshState_ = Xun_TableStateLoadMore;
        [self startMineRequest];
    }];
    
    pageNum_ = 1;
    refreshState_ = Xun_TableStateRefresh;
    [self startMineRequest];
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.proTableView) {
        return proArr_.count;
    }
    else
    {
        if (selectBtnIndex_ == 0) {
            return fromInvArray_.count;
        }
        else if (selectBtnIndex_ == 1)
        {
            return termArray_.count;
        }
        else
        {
            return rateArray_.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.proTableView) {
        Xun_FinacingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"finacingCell"];
        
        cell.model = proArr_[indexPath.row];
        
        cell.PurchaseBtnClickHandler = ^(Xun_FinacingCell *cell){
            if ([Xun_Util isLogined]) {
                Xun_FinacingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                //进入详情
                Xun_InvestmentDetailController *detailVC = [[Xun_InvestmentDetailController alloc] init];
                detailVC.proModel = cell.model;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            else
            {
                [self showLoginViewControllerNeedHideBottomBar:YES];
            }
        };
        
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deqCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deqCell"];
        }
        
        if (selectBtnIndex_ == 0) {
            cell.textLabel.text = fromInvArray_[indexPath.row];
        }
        else if (selectBtnIndex_ == 1)
        {
            cell.textLabel.text = termArray_[indexPath.row];
        }
        else if (selectBtnIndex_ == 2)
        {
            cell.textLabel.text = rateArray_[indexPath.row];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.proTableView) {
        return 120.0f;
    }
    else
    {
        return 30.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.siftTableView) {
        if (selectBtnIndex_ == 0) {
            fromInvState_ = indexPath.row;
        }
        else if (selectBtnIndex_ == 1)
        {
            termState_ = indexPath.row;
        }
        else
        {
            rateState_ = indexPath.row;
        }
        
        [self.popoverView dismiss];
        
        pageNum_ = 1;
        refreshState_ = Xun_TableStateRefresh;
        [self startMineRequest];
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)investmenSiftAction:(id)sender {
    UIButton *button = sender;
    
    if (button == self.fromInvBtn) {
        selectBtnIndex_ = 0;
    }
    else if (button == self.termBtn)
    {
        selectBtnIndex_ = 1;
    }
    else
    {
        selectBtnIndex_ = 2;
    }
    
    [self showPopoverWithPosition:CGPointMake(button.centerX, 64 + 45)];
}

- (void)showPopoverWithPosition:(CGPoint)position
{
    [self.popoverView showAtPoint:position
               popoverPostion:DXPopoverPositionDown
              withContentView:self.siftTableView
                       inView:self.tabBarController.view];
    [self.siftTableView reloadData];
}

#pragma mark -
#pragma mark Request
- (void)startMineRequest
{
    NSDictionary *paramDic = @{
                               @"p" : @(pageNum_),
                               @"unit" : @(fromInvState_),
                               @"duration" : @(termState_),
                               @"rate" : @(rateState_)
                               };
    
    [MBProgressHUD showMessage:@"正在获取" toView:self.tabBarController.view andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppInvestMentUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUDForView:self.tabBarController.view];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            
            NSArray *resultArray = responseObject[@"project"];
            
            if (refreshState_ == Xun_TableStateRefresh) {
                [proArr_ removeAllObjects];
            }
            
            if ([resultArray isKindOfClass:[NSArray class]] && resultArray.count > 0) {
                
                for (NSDictionary *dic in resultArray ) {
                    Xun_FinacingProModel *model = [[Xun_FinacingProModel alloc] initWithJsonDic:dic];
                    [proArr_ addObject:model];
                }
            }
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
        [self.proTableView reloadData];
        
        if (refreshState_ == Xun_TableStateRefresh) {
            [self.proTableView.mj_header endRefreshing];
        }
        else if (refreshState_ == Xun_TableStateLoadMore)
        {
            [self.proTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.tabBarController.view];
        [MBProgressHUD showError:[error localizedDescription]];
        
        if (refreshState_ == Xun_TableStateRefresh) {
            [self.proTableView.mj_header endRefreshing];
        }
        else if (refreshState_ == Xun_TableStateLoadMore)
        {
            [self.proTableView.mj_footer endRefreshing];
        }
    }];
}


@end
