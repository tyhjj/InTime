//
//  Xun_MessageModel.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_MessageModel.h"

@implementation Xun_MessageModel

- (instancetype)initWithJsonDic:(NSDictionary *)JSONValue
{
    if (self = [super initWithJsonDic:JSONValue]) {
        self.itemID = [NSString stringWithFormat:@"%@", JSONValue[@"id"]];;
    }
    return self;
}

@end
