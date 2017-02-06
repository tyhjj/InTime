//
//  Xun_MessageController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_MessageController.h"
#import "Xun_MessageCell.h"
#import "Xun_MessageDetailController.h"

@interface Xun_MessageController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *messageArr_;
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableVIew;

@end

@implementation Xun_MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigation];
    
    [self setUp];
    
    messageArr_ = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startMessageRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.messageTableVIew.width = kXunScreenWidth;
}

#pragma mark -
#pragma mark AboutUI
- (void)setNavigation
{
    self.title = @"消息中心";
    
    [self addLeftBarItem];
}

- (void)setUp
{
    self.messageTableVIew.rowHeight = 80.0f;
    [self.messageTableVIew registerNib:[UINib nibWithNibName:@"Xun_MessageCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
}



#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messageArr_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    cell.model = messageArr_[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_MessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.model.read isEqualToString:@"0"]) {
        [self startStatusChangeRequestWithMessageID:cell.model.itemID];
    }
    
    Xun_MessageDetailController *detailVC = [[Xun_MessageDetailController alloc] init];
    detailVC.model = cell.model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -
#pragma mark Request
- (void)startMessageRequest
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret
                               };
    
    [MBProgressHUD showMessage:@"正在获取" andHideAfterDelay:Xun_TimeOut];
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppUserMessageUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
        [MBProgressHUD hideHUD];
        
        if ([responseInfo.status isEqualToString:Xun_RequestStatusSuccess]) {
            NSArray *messageArray = responseObject;
            
            if (messageArr_.count > 0)
            {
                [messageArr_ removeAllObjects];
            }
            
            BOOL isReaded = YES;
            
            if ([messageArray isKindOfClass:[NSArray class]] && messageArray.count > 0) {
                
                for (NSDictionary *dic in messageArray) {
                    Xun_MessageModel *model = [[Xun_MessageModel alloc] initWithJsonDic:dic];
                    if ([model.read isEqualToString:@"0"]) {
                        isReaded = NO;
                    }
                    [messageArr_ addObject:model];
                }
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:Xun_MessageStatusChangeNotification object:@(isReaded)];
            
            [self.messageTableVIew reloadData];
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

- (void)startStatusChangeRequestWithMessageID:(NSString *)messageID
{
    NSDictionary *paramDic = @{
                               @"oauth_token" : [Xun_Share sharedInstance].session.oauth_token,
                               @"oauth_token_secret" : [Xun_Share sharedInstance].session.oauth_token_secret,
                               @"aid" : messageID
                               };
    
    [Xun_Util POST:[Xun_Util getServerUrlWithSuffix:Xun_AppMessageDidReadUrl] parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject, Xun_ResponseInfo *responseInfo) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
