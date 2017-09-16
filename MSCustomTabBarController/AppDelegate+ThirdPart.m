//
//  AppDelegate+ThirdPart.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/15.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "AppDelegate+ThirdPart.h"
#import "UIView+SnailUse.h"

@implementation AppDelegate (ThirdPart)

-(void)addRootVc
{
  MSTabBarController *tabBarController = [[MSTabBarController alloc] init];
 __weak AppDelegate *weakSelf = self;

 [tabBarController setClickBtn:^(id sender){
  
  SnailFullScreenView *v = [UIView fullScreen];
  v.delegate = weakSelf;
  
  _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleWhiteBlur aView:v];
  _popups.isDismissedOppositeDirection = YES;
  _popups.isAllowPopupsDrag = YES;
  [_popups presentAnimated:YES completion:NULL];

  
  
 }];
  self.window.rootViewController = tabBarController;

}


 // 点击了空白
- (void)fullScreenViewWhenTapped:(SnailFullScreenView *)fullScreenView
{
 [self dismiss];
}
 // 点击了广告
- (void)fullScreenViewDidClickAdvertisement:(UIButton *)advertisement
{
 
}
 // 点击了每个item
- (void)fullScreenView:(SnailFullScreenView *)fullView didClickItemAtIndex:(NSInteger)index
{
 
}

- (void)dismiss {
 [_popups dismissAnimated:YES completion:NULL];
}


@end
