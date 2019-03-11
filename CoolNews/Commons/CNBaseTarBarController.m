//
//  CNBaseTarBarController.m
//  CoolNews
//
//  Created by Zhimi on 2018/2/5.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "CNBaseTarBarController.h"
#import "CNBaseNavigationController.h"
#import "CNMainViewController.h"
#import "CNLeftViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualStateManager.h"

@interface CNBaseTarBarController ()

@property (strong, nonatomic) CNMainViewController *mainVC;
@property (strong, nonatomic) CNLeftViewController *leftVC;
@property (strong,nonatomic) CNBaseNavigationController *mainNavC;
@property (strong,nonatomic) CNBaseNavigationController *leftNavC;
@property (strong,nonatomic) MMDrawerController *leftDrawer_C;

@end

@implementation CNBaseTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.设置标签栏各个选项对应的控制器数组
    [self setViewControllers:@[self.leftDrawer_C]];
    
    //2.设置标签栏控制器默认显示的页面
    [self setSelectedIndex:0];
    //隐藏原本的标签栏
    [self.tabBar setTranslucent:YES];//要设置成透明，不然会影响点击事件
    [self.tabBar setHidden:NO];
    
    self.tabBar.barTintColor = [UIColor colorWithRed:60/255.0 green:57/255.0 blue:61/255.0 alpha:255/255.0];
    
}

- (void)didReceiveMemoryWarning {
    
    NSLog(@"BaseTarBarController");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CNMainViewController *)mainVC{
    
    if (!_mainVC) {
        
        _mainVC  = [CNMainViewController new];
    }
    return _mainVC;
}

- (CNBaseNavigationController *)mainNavC{
    
    if (!_mainNavC) {
        
        _mainNavC   = [[CNBaseNavigationController alloc]initWithRootViewController:self.mainVC];
        //导航栏设为透明
        _mainNavC.navigationBar.translucent = NO;
        [_mainNavC.navigationBar setBackgroundColor:[UIColor colorWithRed:0.14 green:0.80 blue:1.00 alpha:1.00]];
    }
    return _mainNavC;
}

- (CNLeftViewController *)leftVC{
    
    if (!_leftVC) {
        _leftVC  = [CNLeftViewController new];
    }
    return _leftVC;
}

- (CNBaseNavigationController *)leftNavC{
    
    if (!_leftNavC) {
        
        _leftNavC   = [[CNBaseNavigationController alloc]initWithRootViewController:self.leftVC];
        //导航栏设为透明
        _leftNavC.navigationBar.translucent = NO;
        [_leftNavC.navigationBar setBackgroundColor:[UIColor colorWithRed:0.14 green:0.80 blue:1.00 alpha:1.00]];
    }
    return _leftNavC;
}

//实现左边抽屉效果的控制器
-(MMDrawerController *)leftDrawer_C{
    
    if (!_leftDrawer_C) {
        //第三方视图控制（为了实现抽屉效果）
        _leftDrawer_C = [[MMDrawerController alloc]initWithCenterViewController:self.mainNavC leftDrawerViewController:self.leftNavC];
        //打开主页面与抽屉页面衔接间的阴影效果
        [_leftDrawer_C setShowsShadow:YES];
        [_leftDrawer_C setRestorationIdentifier:@"MMDrawer"];
        //设置左抽屉页面的宽度
        [_leftDrawer_C setMaximumLeftDrawerWidth:MINE_VC_WIDTH];
        //启用手势进行打开抽屉页面
        [_leftDrawer_C setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        //启用手势进行关闭抽屉页面
        [_leftDrawer_C setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        //打开抽屉页面的动画效果需要用到
        [_leftDrawer_C
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block;
             block = [[MMDrawerVisualStateManager sharedManager]
                      drawerVisualStateBlockForDrawerSide:drawerSide];
             if(block){
                 block(drawerController, drawerSide, percentVisible);
             }
         }];
    }
    return _leftDrawer_C;
}

@end
