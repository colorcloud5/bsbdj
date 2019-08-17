//
//  GGTopicViewController.m
//  Learning
//
//  Created by 龙超 on 2019/8/14.
//  Copyright © 2019 caiyun. All rights reserved.
//

#import "GGTopicViewController.h"
#import "GGNewViewController.h"
#import "GGTopicCell.h"
#import "GGMyFooter.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface GGTopicViewController ()
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** 所有帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *np;
@property (nonatomic, copy) NSString *connid;

@property (nonatomic, weak) GGTopicCell *cell;
@property (nonatomic, weak) NSIndexPath *indexPath;


@end

@implementation GGTopicViewController

static NSString * const GGTopicCellId = @"topic";
/** 此处实现该方法，仅为了消除Xcode编辑器出现的警告。子类会实现该方法 */
-(GGTopicType)type
{
    return 0;
}

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 系统方法
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTable];
    [self setupRefresh];
}

#pragma mark - 初始化

- (void)setupTable
{
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView.backgroundColor = GGCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GGTabBarH, 0);
    // 指定滚动条在scrollerView中的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGTopicCell class]) bundle:nil] forCellReuseIdentifier:GGTopicCellId];
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [GGMyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

/**
 *  加载最新的帖子数据
 */
- (void)loadNewTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"a"] = [self aParam];
//    params[@"c"] = @"data";
//    params[@"type"] = @(self.type);
    
    NSString *requestURL;
    if (self.type == GGTopicTypeRecommend) {
        if(self.connid == nil){
            requestURL = [GGRecommendURL stringByReplacingOccurrencesOfString:@"#connid" withString:@"0-0"];
        }else{
             requestURL = [GGRecommendURL stringByReplacingOccurrencesOfString:@"#connid" withString:self.connid];
        }
        requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#np" withString:@"0"];
    }else {
        requestURL = [GGOtherURL stringByReplacingOccurrencesOfString:@"#topictype" withString:[NSString stringWithFormat:@"%@",@(self.type)]];
        if (self.connid == nil) {
            requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#connid" withString:@"0-0"];
        }else{
            requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#connid" withString:self.connid];
        }

        requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#np" withString:@"0"];
    }

    // 发送请求d
    __weak typeof(self) weakSelf = self;
    [self.manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        GGLog(@"%@", responseObject);
        // 字典数组 －》 模型数组
        weakSelf.topics = [GGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 存储np
        NSNumber *np = responseObject[@"info"][@"np"];
        weakSelf.np = [np stringValue];

        NSString *firstId = ((GGTopic *)weakSelf.topics[0]).ID;
        NSString *lastId =  ((GGTopic *)weakSelf.topics[weakSelf.topics.count - 1]).ID;
        weakSelf.connid = [NSString stringWithFormat:@"%@-%@",firstId, lastId];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
         [weakSelf.tableView layoutIfNeeded];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadMoreTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"a"] = [self aParam];
//    params[@"c"] = @"data";
//    params[@"type"] = @(self.type);
//    params[@"maxtime"] = self.maxtime;
    NSString *requestURL;
    if (self.type == GGTopicTypeRecommend) {
        requestURL = [GGRecommendURL stringByReplacingOccurrencesOfString:@"#connid" withString:self.connid];
        requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#np" withString:self.np];
    }else {
        requestURL = [GGOtherURL stringByReplacingOccurrencesOfString:@"#topictype" withString:[NSString stringWithFormat:@"%@",@(self.type)]];
        requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#connid" withString:self.connid];
        requestURL = [requestURL stringByReplacingOccurrencesOfString:@"#np" withString:self.np];
    }
    
    // 发送请求
    __weak typeof (self) weakSelf = self;
    [self.manager GET:requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *moreTopics = [GGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        // 存储np
        NSNumber *np = responseObject[@"info"][@"np"];
        weakSelf.np = [np stringValue];
        
        NSString *firstId = ((GGTopic *)moreTopics[0]).ID;
        NSString *lastId =  ((GGTopic *)moreTopics[moreTopics.count - 1]).ID;
        weakSelf.connid = [NSString stringWithFormat:@"%@-%@",firstId, lastId];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        [weakSelf.tableView layoutIfNeeded];
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSString *) aParam
{
    // [a isKindOfClass:c] 判断a是否为c类型或者c的子类类型
    if ([self.parentViewController isKindOfClass:[GGNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}

#pragma mark - tableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:GGTopicCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GGTopic *topic = self.topics[indexPath.row];
    [topic cellHeight];
    cell.topic = topic;

    self.indexPath = indexPath;
    return cell;
}

#pragma mark - tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 模型中已经完成高度的计算
    GGTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:GGTableViewVerticalScrollNotification object:nil];
}

@end
