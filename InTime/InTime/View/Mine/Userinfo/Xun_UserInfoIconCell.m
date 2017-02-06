//
//  Xun_UserInfoIconCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_UserInfoIconCell.h"

@interface Xun_UserInfoIconCell ()


@end

@implementation Xun_UserInfoIconCell

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
    [super layoutSubviews];
    
    self.avatarImage.layer.cornerRadius = self.avatarImage.width / 2.0;
    self.avatarImage.clipsToBounds = YES;
}

@end
