//
//  LCConst.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGConst.h"

@implementation GGConst
/*****  通知  *****/
// tableView垂直方向滚动的通知
NSString * const GGTableViewVerticalScrollNotification = @"GGTableViewVerticalScrollNotification";
// scrollView水平方向滚动完成的通知
NSString * const GGScrollViewDidHorizonScrollNotification = @"GGScrollViewDidHorizonScrollNotification";
// 选中的tabBarItem通知
NSString * const GGTabBarItemSelectedNotification = @"GGTabBarItemSelectedNotification";

/** 请求路径 */
NSString * const GGRequestURL = @"http://api.budejie.com/api/api_open.php";
NSString * const GGRecommendURL = @"http://e.api.budejie.com/v2/topic/feed/1/#connid/bsbdjhd-iphone-5.1.4/#np-20.json";
NSString * const GGOtherURL = @"http://s.budejie.com/v2/topic/list/#topictype/#connid/bsbdjhd-iphone-5.1.4/#np-25.json";

/** 统一的间距 */
CGFloat const GGCommonMargin = 10;

/** 导航栏最大的Y值 */
CGFloat const GGNavBarMaxY = 88;//64

/** GGTitlesView的高度 */
CGFloat const GGTitlesViewH = 35;

/** UITabBar的高度 */
CGFloat const GGTabBarH = 49;

/** 帖子-文字的Y值 */
CGFloat const GGTopicTextY = 55;

/** 最热评论-顶部的高度 */
CGFloat const GGTopicTopCmtTopH = 20;
/** 最热评论-文字的Y值 */
CGFloat const GGTopicTopCmtTextY = 22;

/** 帖子-底部工具条的高度 */
CGFloat const GGTopicToolbarH = 35;
@end
