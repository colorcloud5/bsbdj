//
//  GGTopicContentView.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopicContentView.h"
#import "GGSeeBigImageViewController.h"

@interface GGTopicContentView()



@end;

@implementation GGTopicContentView
- (void)awakeFromNib{
    [super awakeFromNib];
    
    //清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
//    self.userInteractionEnabled = YES;
//    UIGestureRecognizer *gestureRecognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
//    [self.imageView addGestureRecognizer:gestureRecognizer];
}

-(void)imageClick{
//    if (self.imageView == nil) {
//        return;
//    }
//
//    GGSeeBigImageViewController *seeBigPictureVC = [[GGSeeBigImageViewController alloc] init];
//    seeBigPictureVC.topic = self.topic;
//    [self.window.rootViewController presentViewController:seeBigPictureVC animated:YES completion:nil];
}

@end
