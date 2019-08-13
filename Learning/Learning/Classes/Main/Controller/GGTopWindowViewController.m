//
//  LCTopWindowViewController.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopWindowViewController.h"

@interface GGTopWindowViewController ()

@end

@implementation GGTopWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取出所有window
    NSArray *windows = [UIApplication sharedApplication].windows;

    //遍历所有控件
    for (UIWindow *window in windows) {
        [self searchSubviews:window];
    }
}

-(void)searchSubviews:(UIView *)superview
{
    for (UIScrollView *scrollView in superview.subviews) {
        //递归遍历
         [self searchSubviews:scrollView];
        
        if (![scrollView isKindOfClass:[UIScrollView class]])
            continue;
        
        //计算scrollView在window坐标系中的矩形框
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:scrollView.window];
        CGRect windowRect = scrollView.window.bounds;
        
        //判断scrollView和window是否有交集
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;

        //让scrollView滚动到最前
        CGPoint offset = scrollView.contentOffset;
        //偏移量不一定为0
        offset.y = -scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
@end
