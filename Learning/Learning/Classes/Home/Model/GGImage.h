//
//  GGImage.h
//  Learning
//
//  Created by 龙超 on 2019/8/16.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGImage : NSObject
@property (nonatomic, assign) BOOL long_picture;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSArray *thumbnail_link;
@property (nonatomic, copy) NSArray *big;
@end

NS_ASSUME_NONNULL_END
