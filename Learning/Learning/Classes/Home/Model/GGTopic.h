//
//  GGTopic.h
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    /**
     *  推荐
     */
    GGTopicTypeRecommend = 1,
    /**
     *  视频
     */
    GGTopicTypeVideo = 41,
    /**
     *  图片
     */
    GGTopicTypePicture = 10,
    /**
     *  笑话
     */
    GGTopicTypeJoke = 29
}GGTopicType;

@class GGComment;
@interface GGTopic : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

// 发帖者
/**  用户名 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发/分享 数 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数 */
@property (nonatomic, assign) NSInteger comment;
/** 类型 */
@property (nonatomic, assign) GGTopicType type;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 是否动态图 */
@property (nonatomic, assign) BOOL is_gif;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频url */
@property (nonatomic, copy) NSString *videouri;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频url */
@property (nonatomic, copy) NSString *voiceuri;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/**
 *  最热评论
 */
@property (nonatomic, strong) GGComment *top_cmt;

/***** 额外增加的属性 *****/
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  中间内容的frame
 */
@property (nonatomic, assign) CGRect contentFrame;
/**
 *  是否为大图
 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end

NS_ASSUME_NONNULL_END
