//
//  Xun_TradeRecordModel.h
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@interface Xun_TradeRecordModel : Xun_BaseModel

@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *finishtime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *itemID;

@end
