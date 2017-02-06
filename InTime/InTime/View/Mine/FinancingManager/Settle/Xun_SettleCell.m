//
//  Xun_SettleCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SettleCell.h"

@interface Xun_SettleCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *guaranteeBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateLabel;


@end

@implementation Xun_SettleCell

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
    self.guaranteeBtn.layer.cornerRadius = 5.0f;
}

- (void)setModel:(Xun_SettletModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.nameLabel.text = _model.name;
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [_model.income floatValue]];
        self.dateLabel.text = [Xun_Util getTimeStringWithTimeStamp:[_model.repaytime doubleValue] dateFormatter:@"yyyy-MM-dd"];
        
    }
}

@end
