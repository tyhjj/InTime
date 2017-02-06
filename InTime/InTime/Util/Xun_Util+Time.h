//
//  Xun_Util+Time.h
//  GlobalTourism
//
//  Created by xunsmart on 16/7/14.
//  Copyright © 2016年 XunSmart. All rights reserved.
//

#import "Xun_Util.h"

@interface Xun_Util (Time)

/**
 *  把某个格式的时间转换成需要格式的时间字符串
 *
 *  @param date            时间
 *  @param formatterString 时间格式
 *
 *  @return 转换后的字符串
 */
+ (NSString *)getTimeStringWithDate:(NSDate *)date dateFormatter:(NSString *)formatterString;


/**
 *  根据时间戳以及要转换的时间格式转换时间字符串
 *
 *  @param timestamp       时间戳
 *  @param formatterString 时间格式
 *
 *  @return 转换后的字符串
 */
+ (NSString *)getTimeStringWithTimeStamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)formatterString;

/**
 *  根据时间字符串转换成时间戳
 *
 *  @param timstring       时间字符串
 *  @param formatterString 时间格式
 *
 *  @return 时间戳对象
 */
+ (NSNumber *)getTimeStampWithTimeString:(NSString *)timstring formatterString:(NSString *)formatterString;
@end
