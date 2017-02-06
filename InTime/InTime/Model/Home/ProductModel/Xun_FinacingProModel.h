//
//  Xun_FinacingProModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_FinacingProModel : Xun_BaseModel

@property (nonatomic, copy) NSString *name; //名称
@property (nonatomic, copy) NSString *money;    //募集金额
@property (nonatomic, copy) NSString *dbjg; //担保机构
@property (nonatomic, copy) NSString *duration; //募集期限
@property (nonatomic, copy) NSString *unit; //起投金额
@property (nonatomic, copy) NSString *rate; //年利率
@property (nonatomic, copy) NSString *status;   //状态
@property (nonatomic, copy) NSString *amount;   //已募集金额
@property (nonatomic, copy) NSString *interest_paytype; //付息方式：1等额本息，2每月付息，到期还本，3本息到期一次付清
@property (nonatomic, copy) NSString *interest_caltype; //计息方式：1为投标当日计息，2为满额计息
@property (nonatomic, copy) NSString *guarantee_type;   //担保类型：1为担保本息
@property (nonatomic, copy) NSString *process;  //进程状态：0为募集中，1为审核中，2为回款中，3为结束
@property (nonatomic, copy) NSString *recommend;    //首页推荐
@property (nonatomic, copy) NSString *is_new;   //是否新人推荐 0 否 1是
@property (nonatomic, copy) NSString *itemID;

@end
