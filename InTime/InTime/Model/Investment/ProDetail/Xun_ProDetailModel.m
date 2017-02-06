//
//  Xun_ProDetailModel.m
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_ProDetailModel.h"

@implementation Xun_ProDetailModel

- (instancetype)initWithJsonDic:(NSDictionary *)JSONValue
{
    if (self = [super initWithJsonDic:JSONValue]) {
        self.itemID = [NSString stringWithFormat:@"%@", JSONValue[@"id"]];
    }
    return self;
}

@end
