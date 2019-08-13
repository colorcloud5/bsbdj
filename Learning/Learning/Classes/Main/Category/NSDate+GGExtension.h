//
//  NSDate+GGExtension.h
//  BaiSi
//
//  Created by 龙超 on 16/7/29.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GGExtension)

/** 距离当前时间的间隔 */
- (NSDateComponents *) intervalToNow;

/** 比较两时间的间隔 */
-(NSDateComponents *) intervalToDate:(NSDate *)date;

/** 是否为今年 */
- (BOOL) isThisYear;

/** 是否为今天 */
- (BOOL) isToday;

/** 是否为昨天 */
- (BOOL) isYesterday;

/** 是否为明天 */
- (BOOL) isTomorrow;

@end
