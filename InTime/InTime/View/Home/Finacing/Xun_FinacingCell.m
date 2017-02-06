//
//  Xun_FinacingCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_FinacingCell.h"

@interface Xun_FinacingCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *guaranteeBtn;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;


@end

@implementation Xun_FinacingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.guaranteeBtn.layer.cornerRadius  = 3.0f;
    self.purchaseBtn.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_FinacingProModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.nameLabel.text = _model.name;
        [self.guaranteeBtn setTitle:_model.dbjg forState:UIControlStateNormal];
        self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", [_model.rate floatValue]];
        self.dayLabel.text = [NSString stringWithFormat:@"%@天", _model.duration];
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
