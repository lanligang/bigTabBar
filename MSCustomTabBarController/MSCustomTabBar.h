//
//  MSCustomTabBar.h
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/15.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCustomTabBar : UITabBar


typedef void (^selectAction)(id sender);

 /// 中间凸起的按钮
@property (nonatomic, strong) UIButton *centerBtn;


@property (nonatomic, copy) selectAction clickBtn;


@end
