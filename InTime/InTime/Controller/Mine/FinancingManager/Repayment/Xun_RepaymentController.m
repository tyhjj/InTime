//
//  Xun_RepaymentController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RepaymentController.h"
#import "Xun_RepaymentCell.h"

@interface Xun_RepaymentController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation Xun_RepaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
    
    [self.contentTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.contentTableView.width = kXunScreenWidth;
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    self.contentTableView.rowHeight = 120.0f;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"Xun_RepaymentCell" bundle:nil] forCellReuseIdentifier:@"repaymentCell"];
}

#pragma mark -
#pragma mark Property Getter && Setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_RepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repaymentCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

@end
