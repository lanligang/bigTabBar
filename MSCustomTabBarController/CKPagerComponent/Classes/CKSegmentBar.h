//
//  CKSegmentBar.h
//  CKPagerComponent
//
//  Created by mac on 2017/5/1.
//  Copyright © 2017年 corkiios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKSegmentBarConfig.h"
#import "ISegmentBar.h"

@interface CKSegmentBar : UIView<ISegmentBar>

@property (nonatomic, weak) id <ISegmentBar> delegate;

@property (nonatomic, strong) NSArray <NSString *>*items;

@property (nonatomic, assign) NSInteger selectedIndex;

+ (instancetype)segmentBarWithFrame:(CGRect)frame;
//更新标题属性
- (void)updateWithConfig:(void(^)(CKSegmentBarConfig *config))block;
//进度
- (void)setTitleWithProgress:(CGFloat)progress
                 sourceIndex:(NSInteger)sourceIndex
                 targetIndex:(NSInteger)targetIndex;
@end
