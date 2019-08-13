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
    [self setupOneChildViewController:[[GGHomeViewController alloc] init] title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
     [self setupOneChildViewController:[[GGCommunityViewController alloc] init] title:@"社区" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
     [self setupOneChildViewController:[[GGFollowViewController alloc] init] title:@"关注" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
     [self setupOneChildViewController:[[GGMeViewController alloc] init] title:@"我的" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
}


/**
 初始化一个子控制器

 @param vc 子控制器
 @param title 标题
 @param image 图片
 @param selectedImage 选中图片
 */
-(void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    //包装一个导航控制器
    GGNavigationController *nav =[[GGNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    //设置导航控制器的tabBarItem
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
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
