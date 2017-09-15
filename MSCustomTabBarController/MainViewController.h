//
//  MainViewController.h
//  MusicFM
//
//  Created by Macx on 2017/9/2.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, copy)void(^completion)(id obj);


@end
