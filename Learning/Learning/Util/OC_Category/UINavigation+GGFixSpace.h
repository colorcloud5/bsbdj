//
//  GGFixSpace.h
//  Learning
//
//  Created by 龙超 on 2019/8/15.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationConfig : NSObject
/**
 leftItem距离两端的间距,默认为0
 */
@property (nonatomic, assign) CGFloat sx_defaultLeftFixSpace;

/**
 rightItem距离两端的间距,默认为0
 */
@property (nonatomic, assign) CGFloat sx_defaultRightFixSpace;

/**
 是否禁止使用修正,默认为NO
 */
@property (nonatomic, assign) BOOL sx_disableFixSpace;

+ (instancetype)shared;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (CGFloat)sx_systemSpace;

@end

@interface UINavigationItem (SXFixSpace)

@end

@interface NSObject (SXFixSpace)

@end
