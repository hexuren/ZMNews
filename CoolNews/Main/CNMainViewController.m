//
//  CNMainViewController.m
//  CoolNews
//
//  Created by Zhimi on 2018/2/5.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "CNMainViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "YLWArticleModel.h"
#import "YLWNewsTableViewCell.h"
#import "YLWDetailTextViewController.h"
#import "YLWConst.h"
#import "SaoleiViewController.h"

@interface CNMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIButton *topMenuButton;
@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *articleModelArray;
@property (nonatomic,copy) NSString *urlstring;
@property (nonatomic,copy) NSString *titlename;
@property (nonatomic,strong) UIView *coverView;

@end

@implementation CNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setupData{
    self.titlename = @"热门";
    self.urlstring = @"http://api.tuicool.com/api/articles/hot.json?cid=0&size=30";
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNews:) name:@"reloadNews" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoGames:) name:@"gotoGames" object:nil];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

- (void)setupView{
    self.title = @"酷闻";
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:self.topMenuButton];
    self.navigationItem.leftBarButtonItem = menuItem;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.mainTableView.mj_header endRefreshing];
    }];
    self.mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (UIButton *)topMenuButton{
    if (_topMenuButton == nil) {
        _topMenuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_topMenuButton setFrame:CGRectMake(0, 0, 44, 30)];
        [_topMenuButton setImage:[UIImage imageNamed:@"top_menu"] forState:UIControlStateNormal];
        [_topMenuButton addTarget:self action:@selector(topMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topMenuButton;
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
    }
    return _mainTableView;
}

-(UIView *)coverView{
    
    if (_coverView == nil) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor redColor];
        _coverView.frame = self.view.bounds;
        
    }
    return _coverView;
}

-(NSMutableArray *)articleModelArray{
    
    if (_articleModelArray == nil) {
        _articleModelArray = [[NSMutableArray alloc]init];
    }
    return _articleModelArray;
}

#pragma mark - Utilities

-(void)loadData{
    DefineWeakSelf;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if (!manager.isReachable) {
        if ([self.titlename isEqualToString:@"热门"]) {
            [self.articleModelArray addObjectsFromArray:[YLWArticalTool Articalsback]];
            [self.mainTableView reloadData];
        }
    }else {
        if (!self.urlstring) {
            return;
        }
        [YLWArticleModel articleModelGetDataWithURLString:self.urlstring title:self.titlename parameters:nil successblack:^(NSArray *modelArray) {
            if (self.coverView) {
                [weakSelf.coverView removeFromSuperview];
            }
            [weakSelf.articleModelArray removeAllObjects];
            [weakSelf.articleModelArray addObjectsFromArray:modelArray];
            [weakSelf.mainTableView reloadData];
        }];
    }
}

-(void)loadMoreData{
    YLWArticleModel *lastModel = [self.articleModelArray lastObject];
    NSDictionary *par = [[NSDictionary alloc]init];
    if (lastModel) {
        par = @{
                @"last_id":lastModel.id,
                @"last_time":lastModel.uts
                };
    }
    if (!self.urlstring) {
        return;
    }
    DefineWeakSelf;
    [YLWArticleModel articleModelGetDataWithURLString:self.urlstring title:self.titlename parameters:nil successblack:^(NSArray *modelArray) {
        [weakSelf.articleModelArray  addObjectsFromArray:modelArray];
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)reloadNews:(NSNotification *)notification{
    NSMutableArray *plistArr = [NSMutableArray new];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Left" ofType:@"plist"];
    plistArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSInteger index = [notification.object integerValue];
    self.titlename = [plistArr objectAtIndex:index][@"title"];
    self.title = self.titlename;
    self.urlstring = [plistArr objectAtIndex:index][@"urlstring"];
    [self loadData];
}

- (void)gotoGames:(NSNotification *)notification{
    SaoleiViewController *controller = [SaoleiViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)topMenuButton:(UIBarButtonItem *)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articleModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLWArticleModel *model = self.articleModelArray[indexPath.item];
    NSString *ID = @"";
    if (model.img.length > 0) {
        ID = @"YLWNewsTableViewCell";
    }else{
        ID = @"YLWNewsTableViewCell1";
    }
    YLWNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        if ([ID isEqualToString:@"YLWNewsTableViewCell"]) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YLWNewsTableViewCell" owner:nil options:nil] lastObject];
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YLWNewsTableViewCell" owner:nil options:nil] firstObject];
        }
    }
    cell.articleModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLWArticleModel *model = self.articleModelArray[indexPath.row];
    if (self.navigationController) {
        YLWDetailTextViewController *detail = [[YLWDetailTextViewController alloc]init];
//        detail.hidesBottomBarWhenPushed = NO;
        detail.detailTextId = model.id;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:YLWPushToDetailTextVCNotification object:nil userInfo:@{YLWDetailTextIdKeyd:model.id}];
    }
}

@end
