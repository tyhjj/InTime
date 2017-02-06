//
//  Xun_Util+Time.m
//  GlobalTourism
//
//  Created by xunsmart on 16/7/14.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "Xun_Util+Time.h"

@implementation Xun_Util (Time)

+ (NSString *)getTimeStringWithDate:(NSDate *)date dateFormatter:(NSString *)formatterString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatterString;
    
    NSString *timeString = [dateFormatter stringFromDate:date];
    
    return timeString;
}

+ (NSString *)getTimeStringWithTimeStamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)formatterString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [self getTimeStringWithDate:date dateFormatter:formatterString];
}

+ (NSNumber *)getTimeStampWithTimeString:(NSString *)timstring formatterString:(NSString *)formatterString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatterString;
    
    NSDate *date = [dateFormatter dateFromString:timstring];
    
    return @([date timeIntervalSince1970]);
}

@end
