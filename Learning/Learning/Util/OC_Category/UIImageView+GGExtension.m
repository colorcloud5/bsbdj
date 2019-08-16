//
//  UIImage+GGExtension.m
//  BaiSi
//
//  Created by 龙超 on 16/7/25.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "UIImageView+GGExtension.h"
#import <UIImageView+WebCache.h>
#import "UIImage+GGExtension.h"

const CGFloat GGStandOutHeight = 0; // 突出高度 12
const CGFloat GGTabBarHeight = 49; // 设备tabBar高度 一般49

@implementation UIImageView (GGExtension)


/**
 *  画Tabbar背景(中间按钮突出显示的图片)
 *
 *  @return 返回 Tabbar的背景
 */
+ (UIImageView *)gg_DrawTabbarBgImageView
{
    CGFloat radius = 30;// 圆半径
    CGFloat allFloat= (pow(radius, 2)-pow((radius- GGStandOutHeight), 2));
    // 圆弧对应的直线的长度值的一半
    CGFloat halfW = sqrtf(allFloat);
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -GGStandOutHeight, screenW, GGTabBarHeight + GGStandOutHeight)];
    //    imageView.backgroundColor = [UIColor redColor];
    CGSize size = imageView.frame.size;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 计算弧度值
    double angle= asin((radius - GGStandOutHeight)/radius);
    CGFloat startAngle = (float)M_PI + angle;//开始弧度
    CGFloat endAngle = 2*(float)M_PI - angle;//结束弧度
    // 开始画弧：CGPointMake：弧的圆心  radius：弧半径 startAngle：开始弧度 endAngle：结束弧度 clockwise：YES为顺时针，No为逆时针
    [path addArcWithCenter:CGPointMake((size.width)/2, radius) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    // 开始画弧以外的部分
    [path addLineToPoint:CGPointMake(size.width/2 + halfW, GGStandOutHeight)];
    [path addLineToPoint:CGPointMake(size.width, GGStandOutHeight)];
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [path addLineToPoint:CGPointMake(0, GGStandOutHeight)];
    [path addLineToPoint:CGPointMake(size.width/2 - halfW, GGStandOutHeight)];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;// 整个背景的颜色
    layer.strokeColor = [UIColor colorWithWhite:0.765 alpha:1.000].CGColor;//边框线条的颜色
    layer.lineWidth = 0.5;//边框线条的宽
    // 在要画背景的view上 addSublayer:
    [imageView.layer addSublayer:layer];
    return imageView;
}

/**
 *  根据链接设置圆形图片头像
 *
 *  @param url 链接
 */
- (void) setCircleHeaderWithURLString:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
        if (image == nil) return;
        
        weakSelf.image = [image circleImage];
    }];
}

/**
 *  根据链接设置方形图片头像
 *
 *  @param url 链接
 */
- (void) setRectHeaderWithURLString:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
