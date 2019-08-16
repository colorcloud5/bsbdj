//
//  GGTopicVideoView.m
//  Learning
//
//  Created by 龙超 on 2019/8/15.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopicVideoView.h"
#import "GGTopic.h"
#import "GGVideo.h"
#import "GGPlayer.h"
#import <UIImageView+WebCache.h>

@interface GGTopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, strong) GGPlayer *player;
@property (nonatomic, assign, getter=isSmallScreen) BOOL smallScreen;


@end

static GGTopicVideoView const *videoCell;

@implementation GGTopicVideoView


-(void)setTopic:(GGTopic *)topic
{
    [super setTopic:topic];
    
    // 带有播放器的cell被重用时，先清除播放器
    if (self == videoCell) {
        [self releaseGGPlayer];
    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.video.thumbnail[0]]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@次播放", topic.video.playcount];
    
    NSInteger minute = topic.video.duration / 60;
    NSInteger second = topic.video.duration % 60;
    // %02zd ：显示这个数字需要占据2位空间，不足的空间用0替补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    [self.playButton addTarget:self action:@selector(startPlayVideo) forControlEvents:UIControlEventTouchUpInside];
}


//开始播放
-(void)startPlayVideo
{
    if (videoCell != nil && self != videoCell) {// 关闭之前在放的播放视频
        [videoCell releaseGGPlayer];
    }
    
    if (self.player) {
        [self.player removeFromSuperview];
        [self.player setVideoURLStr:self.topic.video.video[0]];
        //        self.htPlayer.videoURLStr = self.topic.videouri;
        
    }else{
        self.player = [[GGPlayer alloc] initWithFrame:self.backView.bounds videoURLStr:self.topic.video.video[0]];
    }
    
    [self.player setPlayTitle:@"百思不得姐"];
    
    [self.backView addSubview:self.player];
    [self bringSubviewToFront:self.backView];
    
    // 保存有播放器的cell
    videoCell = self;
    
    // 监听视频播放完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:)
                                                 name:kHTPlayerFinishedPlayNotificationKey object:nil];
    // 监听tableView垂直滚动通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDie) name:GGTableViewVerticalScrollNotification object:nil];
    // 监听scrollView水平滚动通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPause) name:GGScrollViewDidHorizonScrollNotification object:nil];
    
    
    //    if (self.htPlayer.screenType == UIHTPlayerSizeSmallScreenType) {
    //        [self.htPlayer reductionWithInterfaceOrientation:self.backView];
    //    }
    //    self.isSmallScreen = NO;
}

-(void)videoDidFinished:(NSNotification *)notice{
    
    if (_player.screenType == UIGGPlayerSizeTypeFullScreen){
        
        [self toCell];//先变回cell
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self->_player.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self->_player removeFromSuperview];
        [self sendSubviewToBack:self.backView];
        [self releaseGGPlayer];
    }];
    
}

-(void)toCell{
    
    //    [_htPlayer toDetailScreen:_videoView];
}

-(void)releaseGGPlayer{
    if (_player) {
        [self sendSubviewToBack:self.backView];
        [_player releaseWMPlayer];
        _player = nil;
    }
}

/**
 *  设置视频播放器状态(暂停／销毁 播放器)
 */
-(void) playerDie
{
    if(self.player != nil){
        CGRect rect = [self.backView convertRect:self.backView.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        CGFloat minY = rect.origin.y;
        CGFloat maxY = CGRectGetMaxY(rect);
        
        if (minY > GGScreenH || maxY < 0) {// 垂直不在屏幕上时，销毁播放器
            [self releaseGGPlayer];
        }
    }
    
}

-(void) playerPause
{
    if(self.player != nil){
        CGRect rect = [self.backView convertRect:self.backView.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        CGFloat x = rect.origin.x;
        
        if(x < 0 || x >= GGScreenW){// 水平滚动不在屏幕上时，暂停播放
            [self.player pause];
        }
        
    }
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
