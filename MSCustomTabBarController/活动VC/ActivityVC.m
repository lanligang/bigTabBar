//
//  ActivityVC.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/16.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "ActivityVC.h"
#import "CKPagingManager.h"
#import "PageViewController.h"

#import "MainViewController.h"

@interface ActivityVC ()<IPagingManager>

@end

@implementation ActivityVC{
 
    CKPagingManager *manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   self.automaticallyAdjustsScrollViewInsets = NO;
 
 
   manager = [CKPagingManager manager];
   manager.delegate = self;
 
 [manager loadPagingWithConfig:^(CKSegmentBarConfig *config) {
	//设置正常的颜色
  config.nor_color([UIColor darkGrayColor]);
	//设置选中的颜色
  config.sel_color([UIColor orangeColor]);
	//设置线条的颜色
  config.line_color([UIColor redColor]);
	//设置背景颜色
  config.backgroundColor = [UIColor clearColor];
 }];


}

 //类型
- (CKPagingComponentBarStyle)style {
 
 return CKPagingComponentStyleNormal;
}


/**
 
 控制器集合
 @return 控制器集合
 */
- (NSArray<UIViewController *> *)pagingControllerComponentChildViewControllers {
 
 return @[[PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [PageViewController new],
			 [MainViewController new]
			 ];
}


- (NSArray<NSString *> *)pagingControllerComponentSegmentTitles {
 
 return @[@"热门",@"兴趣",
			 @"红包",@"头条文章",
			 @"直播",@"签到",@"商品",
			 @"音乐",@"点评"];
}

/**
 选项卡位置
 
 @return rect
 */
- (CGRect)pagingControllerComponentSegmentFrame {
 
 return CGRectMake(0, 64, self.view.bounds.size.width, 44);
}

/**
 选项卡位置 中间控制器view 高度
 
 @return CGFloat
 */
- (CGFloat)pagingControllerComponentContainerViewHeight {
 
 return self.view.bounds.size.height - 64;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
