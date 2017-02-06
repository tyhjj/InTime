//
//  Xun_RepaymentCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_RepaymentCell.h"

@interface Xun_RepaymentCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *guaranteeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;


@end

@implementation Xun_RepaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    self.guaranteeLabel.layer.cornerRadius = 5.0;
}

- (void)setModel:(Xun_RepaymentModel *)model
{
    if (_model != model) {
        self.nameLabel.text = _model.name;
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [_model.income_money floatValue]];
        self.durationLabel.text = [_model.pay_type isEqualToString:@"1"] ? @"本金" : @"利息";
        self.dateLabel.text = [Xun_Util getTimeStringWithTimeStamp:[_model.pay_time doubleValue] dateFormatter:@"yyyy-MM-dd"];
    }
}

@end
