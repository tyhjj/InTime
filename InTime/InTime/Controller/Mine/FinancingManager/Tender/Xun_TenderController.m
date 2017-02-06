//
//  Xun_TenderController.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_TenderController.h"
#import "Xun_TenderCell.h"

@interface Xun_TenderController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation Xun_TenderController

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
    [self.contentTableView registerNib:[UINib nibWithNibName:@"Xun_TenderCell" bundle:nil] forCellReuseIdentifier:@"tenderCell"];
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
    Xun_TenderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tenderCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

@end
