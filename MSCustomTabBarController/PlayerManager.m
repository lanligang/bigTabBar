//
//  PlayerManager.m
//  MusicFM
//
//  Created by Macx on 2017/9/8.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager


+(instancetype)share
{
 static PlayerManager *_manger;

 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
  _manger = [[PlayerManager alloc]init];
 });
 return _manger;
}


+(void)playerUrl:(NSString *)url
{
   [[self share]playerUrl:url];
}

 //播放器
- (MCPlayer *)player
{
 if (!_player){
  _player = [MCPlayer makePlayer];
  _player.supportRate =   YES; // 音频 支持这个 会在下载完成之后马上换个本地播放器播放
  _player.backgroundPlay = YES;//后台播放
 }
 return _player;
}


-(void)playerUrl:(NSString *)url
{
 if (_player)
 {
  [_player stopMedia];
  _player = nil;
 }
 	[self.player playMediaWithUrl:url tempPath:nil desPath:nil delegate:self];
}
//结束播放
- (void)playerEnd
{
 [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayEndNotification" object:nil];
 
}

- (void)playerPlayTimeSecond:(CGFloat)seconds currentStr:(NSString *)currentString withResidueStr:(NSString *)residueStr
{
 
 [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayTimeSecondNotification" object:@{@"seconds":@(seconds),@"currentString":currentString,@"residueStr":residueStr}];
 
}
 //播放失败
- (void)playerFailWithMsg:(NSString * )msg
{
 [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayFailNotification" object:msg];

}
/**
 播放暂停
 */
- (void)playerPause
{
  [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayPauseNotification" object:nil];
}

/**
 停止播放
 */
- (void)playerStop
{
 [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayStopNotification" object:nil];

}





@end
