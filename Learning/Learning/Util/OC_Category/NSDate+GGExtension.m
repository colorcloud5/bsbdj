//
//  NSDate+GGExtension.m
//  BaiSi
//
//  Created by 龙超 on 16/7/29.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "NSDate+GGExtension.h"

@implementation NSDate (GGExtension)

/**
 *  距离当前日期时间的间隔
 *
 *  @return 日期时间间隔
 */
- (NSDateComponents *) intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

/**
 *  比较两时间的间隔
 *
 *  @param date 比较的日期时间
 *
 *  @return 日期时间间隔
 */
-(NSDateComponents *) intervalToDate:(NSDate *)date
{
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 比较的元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 比较
    NSDateComponents *dateCmps =  [calendar components:unit fromDate:self toDate:date options:0];
    
    return dateCmps;
}

/**
 *  是否为今年
 *
 *  @return 是否为今年
 */
- (BOOL) isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return selfYear == nowYear;
}

/**
 *  是否为今天
 *
 *  @return  是否为今天
 */
- (BOOL) isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return selfCmps.year == nowCmps.year && selfCmps.month == nowCmps.month && selfCmps.day == nowCmps.day;
}

/**
 *  是否为昨天
 *
 *  @return 是否为昨天
 */
- (BOOL) isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  是否为明天
 *
 *  @return 是否为明天
 */
- (BOOL) isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;

}

@end
