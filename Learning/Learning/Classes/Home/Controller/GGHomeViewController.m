//
//  LCHomeViewController.m
//  Learning
//
//  Created by 龙超 on 2019/8/13.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGHomeViewController.h"
#import "GGRecommendViewController.h"
#import "GGVideoViewController.h"
#import "GGPictureViewController.h"
#import "GGJokeViewController.h"
#import "GGTitleButton.h"
#import "UINavigation+GGFixSpace.h"

@interface GGHomeViewController ()<UIScrollViewDelegate>

/**
 存放所有子控制器的View
 */
@property (nonatomic, weak) UIScrollView *scrollView;

/**
 标题栏
 */
@property (nonatomic, weak) UIView *titlesView;

/**
 当前选中的标题按钮
 */
@property (nonatomic, weak) UIButton *selectedTitleButton;

/**
 标题栏底部的指示器
 */
@property (nonatomic, weak) UIView *titleBottomView;

/**
 所有的标题按钮
 */
@property (nonatomic, strong) NSMutableArray *titleButtons;

@end

@implementation GGHomeViewController

#pragma mark - 懒加载
-(NSMutableArray *)titleButtons{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    
    return _titleButtons;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVcs];
    
    [self setupScrollView];
    
    [self setupTitlesView];
}

-(void)setupNav{
    // 导航栏标题
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左侧内容
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem gg_itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    [UINavigationConfig shared].sx_defaultRightFixSpace = [UINavigationConfig shared].sx_systemSpace;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem gg_itemWithImage:@"icon_navi_search_21x21_" highImage:@"icon_navi_search_21x21_" target:self action:@selector(searchPop)];
}

- (void)setupChildVcs
{
    GGRecommendViewController *recommend = [[GGRecommendViewController alloc] init];
    recommend.title = @"推荐";
    [self addChildViewController:recommend];
    
    GGVideoViewController *video = [[GGVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    GGPictureViewController *picture = [[GGPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    GGJokeViewController *joke = [[GGJokeViewController alloc] init];
    joke.title = @"笑话";
    [self addChildViewController:joke];
}

- (void)setupScrollView
{
    // 不要自动调整scrollview的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = GGCommonBgColor;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    //titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    titlesView.backgroundColor = [UIColor clearColor];
    //预留导航控制器leftBarButtonItem的宽度
    CGFloat space = [UINavigationConfig shared].sx_systemSpace;
    CGFloat rightSpace = 30 + space;//30为单个barButtonItem的宽度
    
    titlesView.frame = CGRectMake(0, GGNavBarMaxY, self.view.width - rightSpace, GGTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    UIBarButtonItem *leftTitlesBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titlesView];
    self.navigationItem.leftBarButtonItem = leftTitlesBarButtonItem;
    
    // 标签栏内部的标签按钮
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonW = titlesView.width / count;
    CGFloat titleButtonH = titlesView.height;
    
    for (int i = 0; i < count; i++) {
        // 创建
        GGTitleButton *titleBtn = [GGTitleButton buttonWithType:UIButtonTypeCustom];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleBtn];
        [self.titleButtons addObject:titleBtn];
        
        // 文字
        NSString *title = [self.childViewControllers[i] title];
        [titleBtn setTitle:title forState:UIControlStateNormal];
        
        // frame
        titleBtn.y = 0;
        titleBtn.height = titleButtonH;
        titleBtn.width = titleButtonW;
        titleBtn.x = i * titleBtn.width;
    }
    
    // 标签底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    titleBottomView.height = 2;
    titleBottomView.y = titlesView.height - titleBottomView.height;
    [titlesView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    // 默认点击最前面的按钮
    GGTitleButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

#pragma mark - 监听方法
/**
 *  导航栏左侧按钮点击
 */
-(void) tagClick
{
//    GGTagViewController *vc = [[GGTagViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void) titleClick:(GGTitleButton *)titleButton
{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.titleButtons indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
    
    //[self scrollViewDidEndDecelerating:self.scrollView];
}

-(void)searchPop{
    NSLog(@"Search");
}

-(void) scanPop
{
    // 1.创建二维码控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"QRCode" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    
    // 2.弹出二维码控制器
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - ScrollView Delegate

/**
 *  当滚动动画完毕的时候调用（通过代码 setContentOffset:animated: 让scrollView滚动完毕后，就会调用此方法）
 *  如果执行完setContentOffset:animated: 后，scrollView的偏移量并没有发生改变，就不会调用
 *  scrollViewDidEndScrollingAnimation: 方法
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:GGScrollViewDidHorizonScrollNotification object:nil];
    
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVC = self.childViewControllers[index];
    
    // 如果控制器的view已经被创建，则直接返回
    if (willShowChildVC.isViewLoaded) return;
    
    // 添加子控制器的view到 scrollView上
    willShowChildVC.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVC.view];
}

/**
 *   当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleButtons[index]];
}

@end
