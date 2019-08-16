
//
//  UITextField+GGExtension.m
//  BaiSi
//
//  Created by 龙超 on 16/7/26.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "UITextField+GGExtension.h"

/**
 *  占位文字颜色
 */
static NSString * const GGPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (GGExtension)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:GGPlaceholderColorKey];
}

-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:GGPlaceholderColorKey];
}

@end
