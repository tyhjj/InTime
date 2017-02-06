//
//  Xun_SettleController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SettleController.h"
#import "Xun_SettleCell.h"

@interface Xun_SettleController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableVIew;

@end

@implementation Xun_SettleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
    
    [self.contentTableVIew reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.contentTableVIew.width = kXunScreenWidth;
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    self.contentTableVIew.rowHeight = 120.0f;
    [self.contentTableVIew registerNib:[UINib nibWithNibName:@"Xun_SettleCell" bundle:nil] forCellReuseIdentifier:@"settleCell"];
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
    Xun_SettleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settleCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

@end
