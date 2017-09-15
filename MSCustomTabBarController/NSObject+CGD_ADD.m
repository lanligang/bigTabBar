//
//  NSObject+CGD_ADD.m
//  MusicFM
//
//  Created by Macx on 2017/9/6.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "NSObject+CGD_ADD.h"

@implementation NSObject (CGD_ADD)


-(void)aSyns:(void (^)())completion
{
 
 dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 dispatch_async(globalQueue, ^{
  if (completion) {
	completion();
  }
 });
}

-(void)mainSys:(void(^)())completion
{
	dispatch_queue_t mainQueue = dispatch_get_main_queue();
	dispatch_async(mainQueue, ^{
	 if (completion) {
	  completion();
	 }
	});

}



@end
