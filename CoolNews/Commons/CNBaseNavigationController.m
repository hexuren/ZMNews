//
//  CNBaseNavigationController.m
//  CoolNews
//
//  Created by Zhimi on 2018/2/5.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "CNBaseNavigationController.h"

@implementation CNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    
    NSLog(@"BaseNavC");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize
{
    // 1.appearance方法返回一个导航栏的外观对象
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    
    //设置状态栏的字体颜色模式
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //lbl修改
    [navigationBar setBarTintColor:gMainColor];
    [navigationBar setTranslucent:NO];
    
    UIView *statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    [statusBarView setBackgroundColor:[UIColor blackColor]];
    [navigationBar addSubview:statusBarView];
    
    [navigationBar setTintColor:[UIColor whiteColor]];//导航栏按钮的标题颜色
    [navigationBar setShadowImage:[UIImage imageNamed:@"shadow"]];//设置一张透明图片遮盖导航栏底下的黑色线条
    
    //3.设置导航栏文字的主题
    NSShadow * shadow = [[NSShadow alloc]init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSShadowAttributeName:shadow}];
    
    //4.修改所有UIBarButton的外观
    
}

@end
