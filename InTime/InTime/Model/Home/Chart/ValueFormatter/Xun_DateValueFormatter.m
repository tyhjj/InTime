//
//  Xun_DateValueFormatter.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_DateValueFormatter.h"

@interface Xun_DateValueFormatter ()

@property (nonatomic, strong) NSArray *dateArray;

@end

@implementation Xun_DateValueFormatter

- (instancetype)initWithArray:(NSArray *)array
{
    if (self = [super init]) {
        self.dateArray = array;
    }
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis
{
    if (value == -1 || value == self.dateArray.count) {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@", self.dateArray[(NSInteger)value]];
    }
}

@end
