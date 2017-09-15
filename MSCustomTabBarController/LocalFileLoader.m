//
//  LocalFileLoader.m
//  MusicFM
//
//  Created by Macx on 2017/9/2.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "LocalFileLoader.h"

static LocalFileLoader *_loader;

@implementation LocalFileLoader

+(instancetype)share
{
	  static dispatch_once_t onceToken;
	  dispatch_once(&onceToken, ^{
    _loader = [[LocalFileLoader alloc]init];
	  });
	  return _loader;
}
+(NSDictionary *)loadJsonFileWithName:(NSString *)name
{
 return [[self share]loadJsonFileWithName:name];
}
-(NSDictionary *)loadJsonFileWithName:(NSString *)name
 {
    NSString *filePath =   [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
 NSData *data = [NSData dataWithContentsOfFile:filePath];
 if (data) {
  NSDictionary *dic =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  if ([dic isKindOfClass:[NSDictionary class]])
  {
	return dic;
  }
 }
 return nil;
 }

@end
