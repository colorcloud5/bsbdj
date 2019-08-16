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
 *  用户
 */
@property (nonatomic, copy) NSString *username;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *sex;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_image;
@end

NS_ASSUME_NONNULL_END
