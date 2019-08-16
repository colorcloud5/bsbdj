
//
//  UIBarButtonItem+GGExtension.m
//  BaiSi
//
//  Created by 龙超 on 16/7/25.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "UIBarButtonItem+GGExtension.h"

@implementation UIBarButtonItem (GGExtension)

+ (instancetype)gg_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
