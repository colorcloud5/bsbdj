//
//  UIImage+GGExtension.h
//  BaiSi
//
//  Created by 龙超 on 16/7/25.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GGExtension)

/**
 *  画Tabbar背景(中间按钮突出显示的图片)
 */
+ (UIImageView *)gg_DrawTabbarBgImageView;

/**
 *  根据链接设置圆形图片头像
 *
 *  @param url 链接
 */
- (void) setCircleHeaderWithURLString:(NSString *)url;

/**
 *  根据链接设置方形图片头像
 *
 *  @param url 链接
 */
- (void) setRectHeaderWithURLString:(NSString *)url;

@end
