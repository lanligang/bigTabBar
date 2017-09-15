//
//  MusicPlayerVC.h
//  MusicFM
//
//  Created by Macx on 2017/9/6.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerVC : UIViewController

@property (nonatomic, strong) NSString		*musicUrl;

@property (nonatomic, strong) NSString		*imageUrl;
@property (nonatomic, strong) NSString		*musicName;

@property (nonatomic, strong) NSArray		*dataSource;

@property (nonatomic, assign) NSInteger currentPlayNum;


@end
