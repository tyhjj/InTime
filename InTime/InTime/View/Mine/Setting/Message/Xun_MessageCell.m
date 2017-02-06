//
//  Xun_MessageCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_MessageCell.h"

@interface Xun_MessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end

@implementation Xun_MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Xun_MessageModel *)model
{
    if (_model != model) {
        _model = model;
        
        self.titleLabel.text = _model.title;
        self.contentLabel.text = _model.comment;
        self.dateLabel.text = [Xun_Util getTimeStringWithTimeStamp:[_model.time doubleValue] dateFormatter:@"yyyy-MM-dd HH:mm"];
        
        if ([_model.read isEqualToString:@"1"]) {
            self.statusLabel.hidden = YES;
        }
        else
        {
            self.statusLabel.hidden = NO;
        }
    }
}
@end
