//
//  Xun_SetValueFormatter.m
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_SetValueFormatter.h"

@implementation Xun_SetValueFormatter

- (NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler
{
    return [NSString stringWithFormat:@"%.2f", entry.y];
}

@end
