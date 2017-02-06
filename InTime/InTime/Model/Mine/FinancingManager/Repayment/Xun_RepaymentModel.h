//
//  Xun_RepaymentModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_RepaymentModel : Xun_BaseModel

@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *tomid;
@property (nonatomic, copy) NSString *frommid;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *puid;
@property (nonatomic, copy) NSString *pay_time; //时间
@property (nonatomic, copy) NSString *income_money; //金额
@property (nonatomic, copy) NSString *pay_type; //1 本金 0 利息
@property (nonatomic, copy) NSString *name; //名称
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *addtime;

@end
