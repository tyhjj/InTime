//
//  Xun_FinacingProModel.m
//  InTime
//
//  Created by xunsmart on 2017/1/12.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_FinacingProModel.h"

@implementation Xun_FinacingProModel

- (instancetype)initWithJsonDic:(NSDictionary *)JSONValue
{
    if (self = [super initWithJsonDic:JSONValue]) {
        self.itemID = [NSString stringWithFormat:@"%@", JSONValue[@"id"]];
    }
    return self;
}

@end
