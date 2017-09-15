//
//  LocalFileLoader.h
//  MusicFM
//
//  Created by Macx on 2017/9/2.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFileLoader : NSObject

+(instancetype)share;
  //加载本地json文件
+(NSDictionary *)loadJsonFileWithName:(NSString *)name;


@end
