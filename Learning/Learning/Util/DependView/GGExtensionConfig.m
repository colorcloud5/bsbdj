//
//  GGExtensionConfig.m
//  Learning
//
//  Created by 龙超 on 2019/8/16.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGExtensionConfig.h"
#import "GGTopic.h"
#import "GGComment.h"
#import <MJExtension.h>

@implementation GGExtensionConfig
+ (void)load{
    [GGTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"top_comments" : @"top_comments[0]"
                 };
    }];
    
    [GGComment mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
}
@end
