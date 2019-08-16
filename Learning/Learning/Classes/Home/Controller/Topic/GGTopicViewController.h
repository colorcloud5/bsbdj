//
//  GGTopicViewController.h
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGTopic.h"

NS_ASSUME_NONNULL_BEGIN

@interface GGTopicViewController : UITableViewController

/**
 帖子的类型

 @return 帖子 类型
 */
-(GGTopicType) type;
@end

NS_ASSUME_NONNULL_END
