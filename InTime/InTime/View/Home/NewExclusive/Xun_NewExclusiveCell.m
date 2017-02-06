//
//  Xun_NewExclusiveCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_NewExclusiveCell.h"

@interface Xun_NewExclusiveCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *guaranteeBtn;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;


@end

@implementation Xun_NewExclusiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.typeBtn.layer.cornerRadius = 2.5f;
    self.guaranteeBtn.layer.cornerRadius = 2.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_FinacingProModel *)model
{
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = _model.name;
        [self.typeBtn setTitle:[self payTypeWithType:_model.interest_paytype] forState:UIControlStateNormal];
        [self.guaranteeBtn setTitle:_model.dbjg forState:UIControlStateNormal];
        self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", [_model.rate floatValue]];
        self.dateLabel.text = [NSString stringWithFormat:@"%@天", _model.duration];
        self.moneyLabel.text = [NSString stringWithFormat:@"募集金额%.2f元", [_model.money floatValue]];
        self.limitLabel.text = [NSString stringWithFormat:@"%ld元起投", [_model.unit  integerValue]];
    }
}

- (NSString *)payTypeWithType:(NSString *)type
{
    if ([type isEqualToString:@"1"]) {
        return @"等额本息";
    }
    else if ([type isEqualToString:@"2"])
    {
        return @"每月付息到期还本";
    }
    else
    {
        return @"本息到期一次付清";
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)purchaseAction:(id)sender {
    if (self.PurchaseBtnClickHandler) {
        self.PurchaseBtnClickHandler(self);
    }
}

@end
