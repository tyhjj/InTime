//
//  Xun_ProDetailModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_ProDetailModel : Xun_BaseModel

@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, copy) NSString *name; //项目名称
@property (nonatomic, copy) NSString *money;    //募集金额
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *dbjg; //担保机构
@property (nonatomic, copy) NSString *addtime;  //添加时间
@property (nonatomic, copy) NSString *duration; //还款周期
@property (nonatomic, copy) NSString *unit; //起投金额
@property (nonatomic, copy) NSString *rate; //年利率
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *amount;   //已募集金额
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *interest_paytype; //1 等额本息 2每月付息 到期还本 3本息到期一次付清
@property (nonatomic, copy) NSString *interest_caltype; //1 投标当日计息  2满额计息
@property (nonatomic, copy) NSString *guarantee_type;   //1 担保本息
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *guarantee;
@property (nonatomic, copy) NSString *repaytime;    //还款日期
@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *recommend;

@end
