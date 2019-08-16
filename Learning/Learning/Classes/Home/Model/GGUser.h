//
//  GGUser.h
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGUser : NSObject
/**
 用户编码
 */
@property (nonatomic, copy) NSString *uid;
/**
 头像
 */
@property (nonatomic, strong) NSArray *header;
/**
 *  用户
 */
@property (nonatomic, copy) NSString *name;
/**
 vip
 */
@property (nonatomic, assign) BOOL is_vip;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
