//
//  GGComment.h
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GGUser;
@interface GGComment : NSObject
/**
 *  id
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  评论内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  用户
 */
@property (nonatomic, strong) GGUser *user;
/**
 *  点赞数
 */
@property (nonatomic, assign) NSInteger like_count;
/**
 *  语音路径
 */
@property (nonatomic, copy) NSString *voiceuri;
/**
 *  语音时长
 */
@property (nonatomic, assign) NSInteger voicetime;
@end

NS_ASSUME_NONNULL_END
