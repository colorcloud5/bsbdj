//
//  GGTopicPictureView.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopicPictureView.h"
#import "GGTopic.h"
#import "GGGif.h"
#import "GGImage.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface GGTopicPictureView ()
{
    __weak UIImageView *_imageView;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageTypeButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation GGTopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setTopic:(GGTopic *)topic
{
    [super setTopic:topic];
    
    NSString *url = [[NSString alloc] init];
    if ([self.topic.type isEqualToString:@"gif"]) {
        url = self.topic.gif.images[0];
    }else if([self.topic.type isEqualToString:@"image"]){
        url = self.topic.image.thumbnail_link[0];
    }
    // 下载图片
    __weak typeof(self) weakSelf = self;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        // 每加载一点图片数据就会来到
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.progressView.progress * 100];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 图片加载完成时调用这个block
        weakSelf.progressView.hidden = YES;
        
        UIImage *scaleImage = [image imageWithSize:CGSizeMake(weakSelf.size.width, weakSelf.size.width * image.size.height / image.size.width)];
        if (topic.image.long_picture || topic.gif.long_picture) {
            self->_imageView.contentMode = UIViewContentModeTop;
            self->_imageView.clipsToBounds = YES;
            self->_imageView.image = scaleImage;
            
        }else{
            self->_imageView.contentMode = UIViewContentModeScaleToFill;
            self->_imageView.clipsToBounds = NO;
        }
    }];
    
    self.imageTypeButton.hidden = NO;
    if ([topic.type isEqualToString:@"gif"]) {
        [self.imageTypeButton setTitle:@"GIF" forState:UIControlStateNormal];
    }
    else if (topic.image.long_picture){
        [self.imageTypeButton setTitle:@"长图" forState:UIControlStateNormal];
    }
    else{
        self.imageTypeButton.hidden = YES;
    }
    
}
@end
