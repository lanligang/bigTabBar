//
//  MSTabBarController.m
//  MSCustomTabBarController
//
//  Created by MrSong on 16/6/7.
//  Copyright © 2016年 MrSong. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSCustomTabBar.h"

#import "UIImage+imgColor.h"


@interface MSTabBarController ()

@end

@implementation MSTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
  // 利用KVO来使用自定义的tabBar
    [self setValue:[[MSCustomTabBar alloc] init] forKey:@"tabBar"];
    [self addAllChildViewController];
    self.tabBar.barTintColor = [UIColor whiteColor];
 
 CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
 UIGraphicsBeginImageContext(rect.size);
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
 CGContextFillRect(context, rect);
 UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
  // [self.tabBar setBackgroundImage:img];
 [self.tabBar setShadowImage:img];
 
// [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarbg3.jpg"]];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"];
    
    UIViewController *activityVC = [[UIViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor greenColor];
 
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
 
  //正常颜色
 [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
																	 [UIColor lightGrayColor], NSForegroundColorAttributeName,
																	 nil] forState:UIControlStateNormal];
  //高亮色
 UIColor *titleHighlightedColor = [UIColor redColor];
 
 [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
																	 titleHighlightedColor, NSForegroundColorAttributeName,
																	 nil] forState:UIControlStateSelected];
 
    nav.tabBarItem.selectedImage = [[[UIImage imageNamed:imageNamed] imageWithColor:[UIColor redColor]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
  //设置选中和未选中的图片
   nav.tabBarItem.image = [[[UIImage imageNamed:imageNamed] imageWithColor:[UIColor blackColor]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    [self addChildViewController:nav];
}


@end