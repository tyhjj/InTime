//
//  Xun_DateValueFormatter.h
//  InTime
//
//  Created by xunsmart on 2017/1/15.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts.h>

@interface Xun_DateValueFormatter : NSObject <IChartAxisValueFormatter>

- (instancetype)initWithArray:(NSArray *)array;

@end
