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


/** 统一的间距 */
CGFloat const GGCommonMargin = 10;

/** 导航栏最大的Y值 */
CGFloat const GGNavBarMaxY = 64;

/** GGTitlesView的高度 */
CGFloat const GGTitlesViewH = 35;

/** UITabBar的高度 */
CGFloat const GGTabBarH = 49;

/** 帖子-文字的Y值 */
CGFloat const GGTopicTextY = 55;

/** 帖子-最热评论-顶部的高度 */
CGFloat const GGTopicTopCmtTopH = 20;

/** 帖子-底部工具条的高度 */
CGFloat const GGTopicToolbarH = 35;
@end
