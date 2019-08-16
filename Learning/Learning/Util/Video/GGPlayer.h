//
//  THPlayer.h
//  THPlayer
//
//  Created by inveno on 16/3/23.
//  Copyright © 2016年 inveno. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MediaPlayer;
@import AVFoundation;

#define kTabBarHeight 49
#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 : 44 )

typedef NS_ENUM(NSInteger, UIGGPlayerSizeType) {
    UIGGPlayerSizeTypeFullScreen     = 0,//全屏
    UIGGPlayerSizeTypeSmallScreen    = 1,//小屏
    UIGGPlayerSizeTypeDetailScreen   = 2,//详情页面显示
    UIGGPlayerSizeTypeRecoveryScreen = 3 //恢复大小
};

typedef NS_ENUM(NSInteger, UIGGPlayerStatusType) {
    UIGGPlayerStatusTypeLoading          = 0,//正在加载
    UIGGPlayerStatusTypeReadyToPlay      = 1,//开始播放
    UIGGPlayerStatusTypeLoadedTimeRanges = 2 //开始缓存
};

extern NSString *const kHTPlayerFinishedPlayNotificationKey; //播放完成通知
extern NSString *const kHTPlayerCloseVideoNotificationKey; //关闭播放视图通知
extern NSString *const kHTPlayerCloseDetailVideoNotificationKey; //关闭详情播放视图
extern NSString *const kHTPlayerFullScreenBtnNotificationKey;//全屏通知
extern NSString *const kHTPlayerPopDetailNotificationKey;//退出详情页面通知
//请求成功
typedef void (^PlayerStatusChange) (UIGGPlayerStatusType status);
typedef void (^PlayerAnimateFinish) (void);

@interface GGPlayer : UIView
/** 为音频文件时的背景图 */
@property (nonatomic, strong) UIImage*bgImage;

@property (assign, nonatomic)UIGGPlayerSizeType screenType;
@property (strong, nonatomic) PlayerStatusChange status;//播放状态
//@property (strong, nonatomic)PlayerAnimateFinish playerAnimateFinish;//To cell 动画完成
@property(nonatomic,copy) NSString *videoURLStr;//播放地址

/** 视频文件播放器 */
- (instancetype)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr;

/** 音频文件播放器 */
- (instancetype)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr bgImage:(UIImage *)bgImage;

- (void)play;
- (void)pause;
- (void)setPlayTitle:(NSString *)str;

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation;
-(void)reductionWithInterfaceOrientation:(UIView *)view;
-(void)toDetailScreen:(UIView *)view;
-(void)toSmallScreen;
-(void)releaseWMPlayer;
-(void)colseTheVideo:(UIButton *)sender;

@end
