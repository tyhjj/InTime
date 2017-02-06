//
//  Xun_PaymentScheduleModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_PaymentScheduleModel : Xun_BaseModel

@property (nonatomic, copy) NSString *day;  //还款时间
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *payment;  //还款金额
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *type; //0 利息 1本金
@property (nonatomic, copy) NSString *interest;
@property (nonatomic, copy) NSString *balance;

@end
