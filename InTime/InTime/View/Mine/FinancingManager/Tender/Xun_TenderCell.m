//
//  Xun_TenderCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_TenderCell.h"

@interface Xun_TenderCell ()


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *guaranteeBtn;
@property (weak, nonatomic) IBOutlet UIButton *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation Xun_TenderCell

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

- (void)setModel:(Xun_TenderModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.nameLabel.text = _model.name;
        self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", [_model.rate floatValue]];
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [_model.money floatValue]];
        self.durationLabel.text = [NSString stringWithFormat:@"%ld", [_model.duration integerValue]];
    }
}

@end
