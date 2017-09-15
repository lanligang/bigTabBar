//
//  AppDelegate+ThirdPart.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/15.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "AppDelegate+ThirdPart.h"

@implementation AppDelegate (ThirdPart)

-(void)addRootVc
{
  MSTabBarController *tabBarController = [[MSTabBarController alloc] init];
 __weak AppDelegate *weakSelf = self;

 [tabBarController setClickBtn:^(id sender){
  
  UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"欢迎使用" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布新内容" otherButtonTitles:@"共享我的代码", nil];
  
  [action showInView:weakSelf.window];
  
  
 }];
  self.window.rootViewController = tabBarController;

}

@end
