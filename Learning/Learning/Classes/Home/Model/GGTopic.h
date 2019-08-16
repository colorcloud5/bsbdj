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
@class GGUser;
@class GGGif;
@class GGImage;
@class GGVideo;
@interface GGTopic : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 资源类型 */
@property (nonatomic, copy) NSString *type;
/** 帖子创建时间 */
@property (nonatomic, copy) NSString *passtime;
/** 发帖者模型 */
@property (nonatomic, strong) GGUser *u;
/** 帖子文字内容 */
@property (nonatomic, copy) NSString *text;
/** 赞数量 */
@property (nonatomic, assign) CGFloat up;
/** 踩数量 */
@property (nonatomic, assign) CGFloat down;
/** 评论数量 */
@property (nonatomic, assign) CGFloat comment;
/** 转发数量 */
@property (nonatomic, assign) CGFloat forward;
/** 最热评论模型 */
@property (nonatomic, strong) GGComment *top_comments;
/** 分享链接 */
@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) GGVideo *video;
@property (nonatomic, strong) GGGif *gif;
@property (nonatomic, strong) GGImage *image;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频url */
@property (nonatomic, copy) NSString *voiceuri;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;



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
