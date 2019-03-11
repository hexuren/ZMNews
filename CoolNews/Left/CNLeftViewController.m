//
//  CNLeftViewController.m
//  CoolNews
//
//  Created by Zhimi on 2018/2/5.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "CNLeftViewController.h"
#import "MineTableViewCell.h"
#import "UIViewController+MMDrawerController.h"


@interface CNLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *infoArr;
@property (strong, nonatomic) UIView *tableHeadView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation CNLeftViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    [self setupData];
    [self setupView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupData{
    [self.nameLabel setText:@"酷闻"];
    [self.logoImageView setImage:[UIImage imageNamed:@"LeftIcon"]];
    
}

- (void)setupView{
    [self.view addSubview:self.mainTableView];
    //表头视图
    [self.mainTableView setTableHeaderView:self.tableHeadView];
    //设置表尾视图
    UIView *tablefootV = [[UIView alloc]init];
    [tablefootV setFrame:CGRectMake(0, 0, MINE_VC_WIDTH, 200)];
    [self.mainTableView setTableFooterView:tablefootV];
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, MINE_VC_WIDTH, SCREEN_HEIGHT+20) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
    }
    return _mainTableView;
}

- (UIView *)tableHeadView{
    if (_tableHeadView == nil) {
        _tableHeadView = [[UIView alloc]init];
        [_tableHeadView setFrame:CGRectMake(0, 0, MINE_VC_WIDTH, 200)];
        [_tableHeadView setBackgroundColor:gMainColor];
        [_tableHeadView addSubview:self.logoImageView];
        [_tableHeadView addSubview:self.nameLabel];

    }
    return _tableHeadView;
}

- (UIImageView *)logoImageView{
    if ( _logoImageView == nil) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MINE_VC_WIDTH - 80)/2, 16+20, 80, 80)];
        [_logoImageView.layer setMasksToBounds:YES];
        [_logoImageView.layer setCornerRadius:10];
        
    }return _logoImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.logoImageView.frame) + 10, MINE_VC_WIDTH - 40, 50)];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setFont:[UIFont systemFontOfSize:24.0]];
        [_nameLabel setTextColor:[UIColor whiteColor]];
    }
    return _nameLabel;
}

- (NSMutableArray *)infoArr{
    if (_infoArr == nil) {
        
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Left" ofType:@"plist"];
        _infoArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    }
    return _infoArr;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.infoArr.count - 1;
    }
    else{
       return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"文章";
    }
    else{
        return @"小游戏";
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell setvalueForcellWithDictionary:self.infoArr[indexPath.row]];
    }
    else{
        [cell setvalueForcellWithDictionary:[self.infoArr lastObject]];
    }
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setSelectedValueForcellWithDictionary:self.infoArr[indexPath.row]];
    }
    else{
        [cell setSelectedValueForcellWithDictionary:[self.infoArr lastObject]];
    }
    //已经打开左抽屉页面后，再调用此句代码即可关闭抽屉页面
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    if (indexPath.section == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadNews" object:@(indexPath.row)];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoGames" object:nil];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    MineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setvalueForcellWithDictionary:self.infoArr[indexPath.row]];
    }
    else{
        [cell setvalueForcellWithDictionary:[self.infoArr lastObject]];
    }

}


@end
