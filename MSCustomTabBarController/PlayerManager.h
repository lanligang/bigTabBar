//
//  PlayerManager.h
//  MusicFM
//
//  Created by Macx on 2017/9/8.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPlayer.h"

@interface PlayerManager : NSObject<MCPlayerDelegate>

@property (nonatomic, assign) NSInteger currentNum;

@property (nonatomic, strong) NSArray		*playModels;




+(instancetype)share;


@property (nonatomic, strong) MCPlayer		*player;


+(void)playerUrl:(NSString *)url;


@end
