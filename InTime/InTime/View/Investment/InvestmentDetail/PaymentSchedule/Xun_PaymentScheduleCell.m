//
//  Xun_PaymentScheduleCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/13.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_PaymentScheduleCell.h"

@interface Xun_PaymentScheduleCell ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;


@end

@implementation Xun_PaymentScheduleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_PaymentScheduleModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [_model.payment floatValue]];
        self.typeLabel.text = [_model.type isEqualToString:@"0"] ? @"利息" : @"利息+本金";
        self.dayLabel.text = _model.day;
    }
}

@end
