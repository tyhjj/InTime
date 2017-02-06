//
//  Xun_CalculatorView.h
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xun_ProDetailModel.h"

@interface Xun_CalculatorView : UIView

@property (nonatomic, strong) Xun_ProDetailModel *detailModel;

@property (nonatomic, copy) void (^closeBtnClickHandler)();
@property (nonatomic, copy) void (^InvestmentBtnClickHandler)(NSInteger investMoney);

@end
