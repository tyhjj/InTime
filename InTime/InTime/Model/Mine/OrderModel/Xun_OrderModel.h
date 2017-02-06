//
//  Xun_OrderModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/16.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_OrderModel : Xun_BaseModel

@property (nonatomic, copy) NSString *inputCharset;
@property (nonatomic, copy) NSString *receiveUrl;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *signType;
@property (nonatomic, copy) NSString *merchantId;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *orderAmount;
@property (nonatomic, copy) NSString *orderCurrency;
@property (nonatomic, copy) NSString *orderDatetime;
@property (nonatomic, copy) NSString *ext1;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *issuerId;
@property (nonatomic, copy) NSString *signMsg;
@property (nonatomic, copy) NSString *productName;

@end
