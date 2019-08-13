//
//  LCTopWindow.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopWindow.h"
#import "GGTopWindowViewController.h"

@implementation GGTopWindow

static UIWindow *win;
+ (void)initialize
{
    win = [[self alloc] init];
}

+(void)show
{
    win.hidden = NO;
    win.backgroundColor = [UIColor clearColor];
}

+(void)hide
{
    win.hidden = YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        self.rootViewController = [[GGTopWindowViewController alloc] init];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame = [UIApplication sharedApplication].statusBarFrame;
   
    [super setFrame:frame];
}
@end
