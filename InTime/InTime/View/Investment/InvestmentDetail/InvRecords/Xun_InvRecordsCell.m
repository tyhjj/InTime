//
//  Xun_InvRecordsCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_InvRecordsCell.h"

@interface Xun_InvRecordsCell ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

@implementation Xun_InvRecordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_InvRecordModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        self.phoneLabel.text = _model.name;
        self.dateLabel.text = _model.addtime;
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元", [_model.money floatValue]];
        
    }
}

@end
