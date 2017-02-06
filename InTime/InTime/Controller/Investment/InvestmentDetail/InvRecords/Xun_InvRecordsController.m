//
//  Xun_InvRecordsController.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_InvRecordsController.h"
#import "Xun_InvRecordsCell.h"

@interface Xun_InvRecordsController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger count_;
}

@property (weak, nonatomic) IBOutlet UITableView *recordsTableView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation Xun_InvRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.recordsTableView.width = kXunScreenWidth;
    self.countLabel.text = [NSString stringWithFormat:@"投资人数：%ld人", count_];
}

#pragma mark -
#pragma mark Property Getter && Setter 
- (void)setDataArray:(NSArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        
        count_ = _dataArray.count;
        self.countLabel.text = [NSString stringWithFormat:@"投资人数：%ld人", count_];
        
        [self.recordsTableView reloadData];
    }
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    self.recordsTableView.rowHeight = 60.0f;
    [self.recordsTableView registerNib:[UINib nibWithNibName:@"Xun_InvRecordsCell" bundle:nil] forCellReuseIdentifier:@"recordsCell"];
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_InvRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordsCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

@end
