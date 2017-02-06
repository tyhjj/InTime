//
//  Xun_BaseModel.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_BaseModel.h"

@implementation Xun_BaseModel

- (instancetype)initWithJsonDic:(NSDictionary *)JSONValue
{
    if (self = [super init]) {
        [self mj_setKeyValues:JSONValue];
    }
    return self;
}

@end
