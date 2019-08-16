//
//  LCTabBarControllerViewController.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTabBarController.h"
#import "GGNavigationController.h"
#import "GGHomeViewController.h"
#import "GGCommunityViewController.h"
#import "GGFollowViewController.h"
#import "GGMeViewController.h"
#import "GGTabBar.h"


@interface GGTabBarController ()

@end

@implementation GGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置UITabBarItem的文字属性
    [self setupItemTitleTextAttributes];
    
    // 添加子控制器
    [self setupChildViewControllers];
    
    // 更换tabbar
    [self setupTabBar];
}


/**
 设置UITabBarItem的文字属性
 */
-(void)setupItemTitleTextAttributes{
    UITabBarItem *item = [UITabBarItem appearance];
    //普通状态下的文字属性
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    //选中状态下的文字
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}


/**
 添加子控制器
 */
-(void)setupChildViewControllers{
    [self setupOneChildViewController:[[GGHomeViewController alloc] init] title:@"首页" image:@"icon_tabbar_home_24x24_" selectedImage:@"icon_tabbar_home_select_24x24_"];
     [self setupOneChildViewController:[[GGCommunityViewController alloc] init] title:@"社区" image:@"icon_tabbar_shequ_24x24_" selectedImage:@"icon_tabbar_shequ_select_24x24_"];
     [self setupOneChildViewController:[[GGFollowViewController alloc] init] title:@"关注" image:@"icon_tabbar_follow_24x24_" selectedImage:@"icon_tabbar_follow_select_24x24_"];
     [self setupOneChildViewController:[[GGMeViewController alloc] init] title:@"我的" image:@"icon_tabbar_mine_24x24_" selectedImage:@"icon_tabbar_mine_select_24x24_"];
}


/**
 初始化一个子控制器

 @param vc 子控制器
 @param title 标题
 @param image 图片
 @param selectedImage 选中图片
 */
-(void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    if ([vc isKindOfClass:[GGCommunityViewController class]]) {
        //设置控制器的tabBarItem
        [self addChildViewController:vc];
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    else{
        //包装一个导航控制器
        GGNavigationController *nav =[[GGNavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
        
        //设置导航控制器的tabBarItem
        nav.tabBarItem.title = title;
        nav.tabBarItem.image = [UIImage imageNamed:image];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
}

-(void)setupTabBar{
    [self setValue:[[GGTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [[NSNotificationCenter defaultCenter] postNotificationName:GGTabBarItemSelectedNotification object:nil userInfo:@{@"title":item.title}];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
