//
//  GGTopicCell.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopicCell.h"
#import "GGTopic.h"
#import "GGComment.h"
#import "GGUser.h"
#import "GGTopicPictureView.h"
#import "GGTopicVideoView.h"
#import "GGTopicJokeView.h"

@interface  GGTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *txtLabel;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


/**
 视频
 */
@property (nonatomic, weak) GGTopicVideoView *videoView;

/**
 图片
 */
@property (nonatomic, weak) GGTopicPictureView *pictureView;

/**
 笑话
 */
@property (nonatomic, weak) GGTopicJokeView *jokeView;

/**
 最热评论整体
 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UIImageView *topCmtProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCmtZanLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@end

@implementation GGTopicCell
#pragma mark - 懒加载
-(GGTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        GGTopicPictureView *pictureView = [GGTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    
    return _pictureView;
}

-(GGTopicVideoView *)videoView
{
    if (_videoView == nil) {
        GGTopicVideoView *videoView = [GGTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    
    return _videoView;
}

#pragma mark - 系统方法
-(void)awakeFromNib
{
    [super awakeFromNib];
    // 设置cell的背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += GGCommonMargin;
    frame.size.height -= GGCommonMargin;
    
    [super setFrame:frame];
}

#pragma mark - 自定义方法
-(void)setTopic:(GGTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView setCircleHeaderWithURLString:topic.u.header[0]];
    self.nameLabel.text = topic.u.name;
    self.createdAtLabel.text = topic.passtime;
    self.txtLabel.text = topic.text;
    
    // 设置底部工具条的数据
    [self setupButtonTitle:self.zanButton number:topic.up placeholder:@"赞"];
    [self setupButtonTitle:self.caiButton number:topic.down placeholder:@"踩"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    [self setupButtonTitle:self.shareButton number:topic.forward placeholder:@"分享"];
    
    // 根据帖子的类型决定中间的内容
    
     if([topic.type isEqualToString:@"video"]){// 视频
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;
     }else if ([topic.type isEqualToString:@"image"] || [topic.type isEqualToString:@"gif"] ) {// 图片
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
     }else if([topic.type isEqualToString:@"text"]){// 笑话
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 最热评论
    if (topic.top_comments) {
        self.topCmtView.hidden = NO;
        NSString *username = topic.top_comments.u.name;
        NSString *content = topic.top_comments.content;
        self.topCmtNameLabel.text = username;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username, content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
}

- (void) setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    }else if(number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

#pragma mark - 监听方法
- (IBAction)moreClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GGLog(@"收藏");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GGLog(@"举报");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        GGLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
