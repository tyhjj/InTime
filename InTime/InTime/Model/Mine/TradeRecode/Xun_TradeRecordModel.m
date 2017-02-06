//
//  Xun_TradeRecordModel.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_TradeRecordModel.h"

@implementation Xun_TradeRecordModel

- (instancetype)initWithJsonDic:(NSDictionary *)JSONValue
{
    if (self = [super initWithJsonDic:JSONValue]) {
        self.itemID = [NSString stringWithFormat:@"%@", JSONValue[@"id"]];
        self.typeName = [NSString stringWithFormat:@"%@", JSONValue[@"typename"]];
    }
    return self;
}

@end
