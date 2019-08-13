//
//  LCTabBar.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTabBar.h"
#import "UIImageView+GGExtension.h"
#import "UIView+GGExtension.h"

@interface GGTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation GGTabBar

#pragma mark -lazy load
/**
 发布按钮

 @return tabBar中间的发布按钮
 */
-(UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    
    return _publishButton;
}

#pragma mark -初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *bgImageView = [UIImageView gg_DrawTabbarBgImageView];
        bgImageView.userInteractionEnabled = YES;
        [self insertSubview:bgImageView atIndex:0];
        self.opaque = YES;
        
        //取消tabBar的上边框线条
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        [self setShadowImage:[[UIImage alloc] init]];
    }
    
    return  self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width / 5;
    CGFloat btnH = self.height;
    
    int tabBarButtonIndex = 0;
    for (UIView *subview in self.subviews) {
        // 过滤掉不是UITabBarButton的子控件
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat barBarButtonX = tabBarButtonIndex * btnW;
        if (tabBarButtonIndex >= 2) {
            barBarButtonX += btnW;
        }
        
        subview.frame = CGRectMake(barBarButtonX, 0, btnW, btnH);
        //增加索引
        tabBarButtonIndex++;
    }
    
    // 设置中间的发布按钮
    self.publishButton.centerX = self.width * 0.5;
    self.publishButton.centerY = self.height * 0.5 - 20;
    self.publishButton.width = btnW;
    self.publishButton.height = btnH;
}

#pragma mark - 监听
- (void) publishButtonClick:(UIButton *)btn
{
    GGLogFunc;
}
@end
