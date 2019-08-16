//
//  GGSeeBigImageViewController.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGSeeBigImageViewController.h"
#import "GGTopic.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface GGSeeBigImageViewController ()

/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *imageView;
/**
 *  相册库
 */
@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation GGSeeBigImageViewController

-(ALAssetsLibrary *)library
{
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    
    return _library;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 滚动控件
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    // 图片
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
//    [scrollView addSubview:imageView];
//    self.imageView = imageView;
    
    // 图片的尺寸
//    imageView.x = 0;
//    imageView.width = GGScreenW;
//    imageView.height = imageView.width * self.topic.height / self.topic.width;
//    if (imageView.height > GGScreenH) {// 图片长度超出屏幕高度
//        imageView.y = 0;
//        scrollView.contentSize = CGSizeMake(0, imageView.height);
//    }else{// 图片居中显示
//        imageView.centerY = GGScreenH * 0.5;
//    }
//    
//    // 伸缩
//    CGFloat maxScale = self.topic.height / imageView.height;
//    if (maxScale >1.0) {
//        scrollView.maximumZoomScale = maxScale;
//    }
}

#pragma mark - 监听方法
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

static NSString * const GGGroupNameKey = @"GGGroupNameKey";
static NSString * const GGDefaultGroupName = @"BaiSi";
- (IBAction)save {
    // 获取保存文件夹的名字
    __block NSString *groupName = [self groupName];
    
    __weak typeof(self) weakSelf = self;
    // 图片库
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    
    // 创建文件夹
    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        if (group) {// 新创建的文件夹
            // 添加图片到文件夹中
            [weakSelf addImageToGroup:group];
        }else{// 文件夹已存在
            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:groupName]) {// 是自己创建的文件夹
                    // 添加图片到文件夹中
                    [weakSelf addImageToGroup:group];
                    // 停止遍历
                    *stop = YES;
                }else if([name isEqualToString:@"Camera Roll"]){// 文件夹已被用户强制删除
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新的名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:GGGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    //创建新的文件夹
                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                        // 添加图片到文件夹
                        [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
            } failureBlock:nil];
        }
    } failureBlock:nil];
    
}

/** 获取相册名 */
- (NSString *) groupName
{
    // 从沙盒中获取名字
    NSString *groupName = [[NSUserDefaults standardUserDefaults] objectForKey:GGGroupNameKey];
    
    if (groupName == nil) {
        groupName = GGDefaultGroupName;
        // 存储名字到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:GGGroupNameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return groupName;
}

-(void) addImageToGroup:(ALAssetsGroup *)group
{
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    // 需要保存的图片
    CGImageRef image = self.imageView.image.CGImage;
    // 添加图片到相机胶卷
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            // 添加一张图片到自定义的文件夹
            [group addAsset:asset];
            [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
        } failureBlock:nil];
    }];
}

- (void)getAllPhotos
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // 遍历所有的文件夹, 一个ALAssetsGroup对象就代表一个文件夹
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // 遍历文件夹内的所有多媒体文件（图片、视频）, 一个ALAsset对象就代表一张图片
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            // 缩略图
            GGLog(@"%@", [UIImage imageWithCGImage:result.thumbnail]);
            // 获得原始图片
            //            XMGLog(@"%@", [UIImage imageWithCGImage:result.defaultRepresentation.fullResolutionImage]);
        }];
        
    } failureBlock:nil];
}

#pragma mark - scroll view Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}


@end
