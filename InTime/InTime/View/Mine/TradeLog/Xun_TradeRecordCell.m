//
//  Xun_TradeRecordCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_TradeRecordCell.h"

@interface Xun_TradeRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation Xun_TradeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_TradeRecordModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.typeLabel.text = [self getTypeNameWithType:_model.type];
        if ([_model.type isEqualToString:@"recharge"] || [_model.type isEqualToString:@"thaw"]) {
            self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f", [_model.money floatValue]];
            self.moneyLabel.textColor = Xun_ColorFromHex(0xF04C0B);
        }
        else
        {
            self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f", [_model.money floatValue]];
            self.moneyLabel.textColor = Xun_BaseBlueColor;
        }
        self.timeLabel.text = [Xun_Util getTimeStringWithTimeStamp:[_model.finishtime doubleValue] dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.stateLabel.text = [_model.status isEqualToString:@"1"] ? @"成功" : @"失败";
    }
}

- (NSString *)getTypeNameWithType:(NSString *)type
{
    if ([type isEqualToString:@"recharge"]) {
        return @"充值";
    }
    else if ([type isEqualToString:@"cash"])
    {
        return @"提现";
    }
    else if ([type isEqualToString:@"freeze"])
    {
        return @"冻结资金";
    }
    else if ([type isEqualToString:@"transfer"])
    {
        return @"从冻结资金转入";
    }
    else
    {
        return @"解冻资金";
    }
}

@end
