//
//  Xun_PaymentScheduleController.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_PaymentScheduleController.h"
#import "Xun_PaymentScheduleCell.h"

@interface Xun_PaymentScheduleController () <UITableViewDelegate, UITableViewDataSource>
{
    float totalMoney_;
}

@property (weak, nonatomic) IBOutlet UITableView *recordTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation Xun_PaymentScheduleController

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
    self.recordTableView.width = kXunScreenWidth;
    
     self.totalLabel.text = self.totalLabel.text = [NSString stringWithFormat:@"待回本息:%.2f", totalMoney_];
}

#pragma mark -
#pragma mark AboutUI
- (void)setUp
{
    [self.recordTableView registerNib:[UINib nibWithNibName:@"Xun_PaymentScheduleCell" bundle:nil] forCellReuseIdentifier:@"scheduleCell"];
    self.recordTableView.sectionHeaderHeight = 60.0f;
}

- (UILabel *)createLabel
{
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, 100, 30);
    label.textColor = Xun_ColorFromHex(0x666666);
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

#pragma mark -
#pragma mark Property Getter && Setter
- (void)setDataArray:(NSArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        
        totalMoney_ = 0;
        for (Xun_PaymentScheduleModel  *model in _dataArray) {
            totalMoney_ += [model.payment floatValue];
        }
        
        self.totalLabel.text = [NSString stringWithFormat:@"待回本息:%.2f", totalMoney_];
        [self.recordTableView reloadData];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xun_PaymentScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    header.frame = CGRectMake(0, 0, kXunScreenWidth, 60.0f);
    
    UILabel *moneyLabel = [self createLabel];
    moneyLabel.centerX = header.width / 2 * 0.333;
    moneyLabel.centerY = header.height / 2.0;
    moneyLabel.text = @"回款金额";
    [header addSubview:moneyLabel];
    
    UILabel *typeLabel = [self createLabel];
    typeLabel.centerY = moneyLabel.centerY;
    typeLabel.centerX = header.width / 2.0;
    typeLabel.text = @"回款类型";
    [header addSubview:typeLabel];
    
    UILabel *dateLabel = [self createLabel];
    dateLabel.centerY = moneyLabel.centerY;
    dateLabel.centerX = header.width / 2.0 * 1.667;
    dateLabel.text = @"回款时间";
    [header addSubview:dateLabel];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(0, header.height - 0.5, header.width, 0.5);
    line.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:line];
    
    return header;
}

@end
