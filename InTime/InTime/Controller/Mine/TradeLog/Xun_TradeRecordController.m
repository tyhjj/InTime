//
//  Xun_TradeRecordController.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_TradeRecordController.h"
#import "Xun_TradeRecordCell.h"
#import "Xun_RNAuthenticationController.h"

@interface Xun_TradeRecordController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *recordArr_;
    
    NSUInteger pageNum_;
    Xun_TableRefreshState refreshState_;
}

@property (weak, nonatomic) IBOutlet UITableView *tradeTableView;

@end

@implementation Xun_TradeRecordController

#pragma mark -
#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    recordArr_ = [NSMutableArray array];
    
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
    self.title = @"交易记录";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    self.tradeTableView.rowHeight = 65.0f;
    [self.tradeTableView registerNib:[UINib nibWithNibName:@"Xun_TradeRecordCell" bundle:nil] forCellReuseIdentifier:@"tradeCell"];
    
    self.tradeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNum_ = 1;
        refreshState_ = Xun_TableStateRefresh;
        [self startRecordRequest];
    }];
    self.tradeTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        pageNum_ ++;
        refreshState_ = Xun_TableStateLoadMore;
        [self startRecordRequest];
    }];
    
    pageNum_ = 1;
    refreshState_ = Xun_TableStateRefresh;
    [self startRecordRequest];
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recordArr_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_TradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tradeCell"];
    
    cell.model = recordArr_[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Request
- (void)startRecordRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"p" : @(pageNum_)
                               };
    
    [MBProgressHUD showMessage:@"正在加载" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppTradeRecordeUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            
            if ([dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
                if (refreshState_ == Xun_TableStateRefresh) {
                    [recordArr_ removeAllObjects];
                }
                for (NSDictionary *dic in dataArray) {
                    Xun_TradeRecordModel *model = [[Xun_TradeRecordModel alloc] initWithJsonDic:dic];
                    [recordArr_ addObject:model];
                }
            }
        }
        else if ([responseInfo.status isEqualToString:Xun_RequestStatusRNAuthNone])
        {
            //未实名认证
            Xun_RNAuthenticationController *rnAuthVC = [[Xun_RNAuthenticationController alloc] init];
            [self.navigationController pushViewController:rnAuthVC animated:YES];
        }
        else
        {
            [MBProgressHUD showError:responseInfo.msg];
        }
        
        [self.tradeTableView reloadData];
        
        if (refreshState_ == Xun_TableStateRefresh) {
            [self.tradeTableView.mj_header endRefreshing];
        }
        else
        {
            [self.tradeTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[error localizedDescription]];
        if (refreshState_ == Xun_TableStateRefresh) {
            [self.tradeTableView.mj_header endRefreshing];
        }
        else
        {
            [self.tradeTableView.mj_footer endRefreshing];
        }
    }];
}

@end
