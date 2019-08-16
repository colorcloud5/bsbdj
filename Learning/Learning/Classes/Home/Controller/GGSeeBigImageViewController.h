//
//  GGSeeBigImageViewController.h
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GGTopic;
@interface GGSeeBigImageViewController : UIViewController

/**
 帖子模型
 */
@property (nonatomic, strong) GGTopic *topic;

@end

NS_ASSUME_NONNULL_END
