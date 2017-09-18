//
//  NSString+ShotSeconds.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/18.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "NSString+ShotSeconds.h"

@implementation NSString (ShotSeconds)



-(NSString *)secondsToH_M_S
{
    NSInteger seconds  =   [self   integerValue];
 
	 NSInteger h = seconds/36000 ;
 
	 seconds = seconds%36000;
 
    NSInteger m =seconds/60;
    seconds = seconds%60;
 
return  [NSString stringWithFormat:@"%ld:%ld:%ld",(long)h,(long)m,(long)seconds];
 
 
}
@end
