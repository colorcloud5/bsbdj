//
//  UIColor+GGExtension.h
//  BaiSi
//
//  Created by 龙超 on 16/8/5.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GGExtension)


+ (UIColor *) colorWithHex:(uint)hex;

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) colorWitHexString:(NSString *)hexString;


@end
