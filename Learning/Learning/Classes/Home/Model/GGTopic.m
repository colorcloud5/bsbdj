//
//  GGTopic.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopic.h"
#import "GGComment.h"
#import "GGUser.h"

@implementation GGTopic

-(NSString *)created_at
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString 转 NSDate
    NSDate *createdAtDate = [fmt dateFromString:_created_at];
    
    // 比较当前时间和发帖时间
    NSDateComponents *cmps = [createdAtDate intervalToNow];
    if (createdAtDate.isThisYear) {// 今年
        if (createdAtDate.isToday) {// 今天
            if (cmps.hour >= 1) {// 时间差 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if(cmps.minute >= 1){// 1分钟 <= 时间差 <= 1小时
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else{// 时间差 < 1分钟
                return @"刚刚";
            }
        }else if(createdAtDate.isYesterday){// 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }else{// 其它时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
        
    }else{// 非今年
        return _created_at;
    }
    
    return nil;
}

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        // cell 的高度
        _cellHeight = GGTopicTextY;
        
        // 计算文字的高度
        CGFloat textW = GGScreenW - 2 * GGCommonMargin;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight += textH + GGCommonMargin;
        
        // 中间内容的高度
        if (self.type != GGTopicTypeJoke) {
            CGFloat contentW = textW;
            CGFloat contentH = contentW * self.height / self.width;
            if (contentH > GGScreenH) { // 当图片的高度超过一个屏幕的高度时，将图片高度设置为200
                contentH = 200;
                self.bigPicture = YES;
            }
            
            CGFloat contentX = GGCommonMargin;
            CGFloat contentY = _cellHeight;
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            
            _cellHeight += contentH + GGCommonMargin;
        }
        
        // 最热评论
        if (self.top_cmt) {
            NSString *username = self.top_cmt.user.username;
            NSString *content = self.top_cmt.content;
            NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
            
            // 评论内容的高度
            CGFloat cmtTextH = [cmtText boundingRectWithSize:CGSizeMake(textW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14] } context:nil].size.height;
            
            _cellHeight += GGTopicTopCmtTopH + cmtTextH + GGCommonMargin;
        }
        
        // 加上工具条的高度
        _cellHeight += GGTopicToolbarH + GGCommonMargin;
    }
    
    return _cellHeight;
}

@end
