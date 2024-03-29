//
//  LCConst.h
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGConst : NSObject
// tableView垂直方向滚动的通知
UIKIT_EXTERN NSString * const GGTableViewVerticalScrollNotification;
// scrollView水平方向滚动完成的通知
UIKIT_EXTERN NSString * const GGScrollViewDidHorizonScrollNotification;
// 选中的tabBarItem通知
UIKIT_EXTERN NSString * const GGTabBarItemSelectedNotification;

/** 请求路径 */
UIKIT_EXTERN NSString * const GGRequestURL;
UIKIT_EXTERN NSString * const GGRecommendURL;
UIKIT_EXTERN NSString * const GGOtherURL;

/** 统一的间距 */
UIKIT_EXTERN CGFloat const GGCommonMargin;

/** 导航栏最大的Y值 */
UIKIT_EXTERN CGFloat const GGNavBarMaxY;

/** GGTitlesView的高度 */
UIKIT_EXTERN CGFloat const GGTitlesViewH;

/** UITabBar的高度 */
UIKIT_EXTERN CGFloat const GGTabBarH;

/** 帖子-文字的Y值 */
UIKIT_EXTERN CGFloat const GGTopicTextY;

/** 最热评论-顶部的高度 */
UIKIT_EXTERN CGFloat const GGTopicTopCmtTopH;
/** 最热评论-文字的Y值 */
UIKIT_EXTERN CGFloat const GGTopicTopCmtTextY;
/** 帖子-底部工具条的高度 */
UIKIT_EXTERN CGFloat const GGTopicToolbarH;
@end

NS_ASSUME_NONNULL_END
