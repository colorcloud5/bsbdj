//
//  GGVideo.h
//  Learning
//
//  Created by 龙超 on 2019/8/16.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGVideo : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *playcount;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSArray *thumbnail;
@property (nonatomic, strong) NSArray *video;

@end

NS_ASSUME_NONNULL_END
