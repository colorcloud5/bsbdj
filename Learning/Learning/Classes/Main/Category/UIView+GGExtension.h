//
//  UIView+GGExtension.h
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GGExtension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign, readonly) CGPoint origin;
@property (nonatomic, assign, readonly) CGPoint bottomLeft;
@property (nonatomic, assign, readonly) CGPoint bottomRight;
@property (nonatomic, assign, readonly) CGPoint topRight;


+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;

- (void) moveBy: (CGPoint) delta;

- (void) scaleBy: (CGFloat) scaleFactor;

- (void) fitInSize: (CGSize) aSize;

@end

NS_ASSUME_NONNULL_END
