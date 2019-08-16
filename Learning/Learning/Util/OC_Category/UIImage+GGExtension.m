//
//  UIImage+GGExtension.m
//  BaiSi
//
//  Created by 龙超 on 16/7/28.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "UIImage+GGExtension.h"

@implementation UIImage (GGExtension)

/**
 *  返回圆形图片
 *
 *  @return 圆形图片
 */
- (instancetype) circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 新建一个矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.width);
    // 添加一个圆到矩形框
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上画一张图片
    [self drawInRect:rect];
    // 获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  返回圆形图片
 *
 *  @param name 图片名称
 *
 *  @return 圆形图片
 */
+ (instancetype) circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

/**
 *  将图片进行缩放
 *
 *  @param size 缩放后的尺寸
 *
 *  @return 缩放后的图片
 */
- (instancetype) imageWithSize:(CGSize)size
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(size);
    
    // 新建一个矩形框
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 往矩形框上画一张图片
    [self drawInRect:rect];
    // 获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
