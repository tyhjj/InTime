//
//  Xun_SymbolsValueFormatter.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SymbolsValueFormatter.h"

@implementation Xun_SymbolsValueFormatter

- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis
{
    return [NSString stringWithFormat:@"%ldK",(NSInteger)value];
}

@end
