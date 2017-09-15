//
//  WebVc.h
//  HeroDesigners
//
//  Created by Macx on 2017/7/22.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface FileQuickLookDeleVc : UIViewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property(nonatomic,strong)NSURL *fileURL;

@property(nonatomic,strong)NSString *localString;

@end
