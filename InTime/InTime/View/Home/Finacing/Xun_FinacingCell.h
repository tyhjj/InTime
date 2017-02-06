//
//  Xun_FinacingCell.h
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xun_FinacingProModel.h"

@interface Xun_FinacingCell : UITableViewCell

@property (nonatomic, strong) Xun_FinacingProModel *model;

@property (nonatomic, copy) void (^PurchaseBtnClickHandler)(Xun_FinacingCell *cell);

@end
