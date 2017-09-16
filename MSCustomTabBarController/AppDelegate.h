//
//  AppDelegate.h
//  MSCustomTabBarController
//
//  Created by MrSong on 16/6/7.
//  Copyright © 2016年 MrSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTabBarController.h"
#import "SnailQuickMaskPopups.h"
#import "SnailFullScreenView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SnailFullScreenViewDelegate>
{
 SnailQuickMaskPopups *_popups;
}
@property (strong, nonatomic) UIWindow *window;




@end

