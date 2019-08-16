//
//  NSBundle+GGPlayer.m
//  BaiSi
//
//  Created by 龙超 on 16/8/3.
//  Copyright © 2016年 caiyun. All rights reserved.
//

#import "NSBundle+GGPlayer.h"

@implementation NSBundle (GGPlayer)

+ (instancetype)gg_playerBundle
{
    static NSBundle *playerBundle = nil;
    if (playerBundle == nil) {
        playerBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GGPlayer" ofType:@"bundle"]];
    }
    return playerBundle;
}

+ (UIImage *)gg_imageNamed:(NSString *)name
{
    UIImage *image = nil;
    if (image == nil) {
        image = [[UIImage imageWithContentsOfFile:[[self gg_playerBundle] pathForResource:name ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}


@end
