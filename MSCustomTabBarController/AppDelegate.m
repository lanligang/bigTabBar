//
//  AppDelegate.m
//  MSCustomTabBarController
//
//  Created by MrSong on 16/6/7.
//  Copyright © 2016年 MrSong. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+ThirdPart.h"


#import <AVFoundation/AVFoundation.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];
 [self addRootVc];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationWillResignActive:(UIApplication *)application
{
  //开启后台处理多媒体事件
 [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
 AVAudioSession *session=[AVAudioSession sharedInstance];
 [session setActive:YES error:nil];
  //后台播放
 [session setCategory:AVAudioSessionCategoryPlayback error:nil];
  //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
  // _bgTaskId=[AppDelegate backgroundPlayerID:@"123123"];
}
 //实现一下backgroundPlayerID:这个方法:
+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
  //设置并激活音频会话类别
 AVAudioSession *session=[AVAudioSession sharedInstance];
 [session setCategory:AVAudioSessionCategoryPlayback error:nil];
 [session setActive:YES error:nil];
  //允许应用程序接收远程控制
 [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
  //设置后台任务ID
 UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
 newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
 if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
  {
  [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
  }
 return newTaskId;
}



@end
