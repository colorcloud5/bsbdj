//
//  UIBarButtonItem+GGExtension.h
//  BaiSi
//
//  Created by 龙超 on 16/7/25.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GGExtension)
+ (instancetype)gg_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
