//
//  Xun_SettletModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_SettletModel : Xun_BaseModel

@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *name; //名称
@property (nonatomic, copy) NSString *rate; //年利率
@property (nonatomic, copy) NSString *money;    //投资金额
@property (nonatomic, copy) NSString *amount;   //已募集
@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *duration; //期限(天)
@property (nonatomic, copy) NSString *repaytime;    //结清日期
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *loan;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *userid;

@end
