//
//  MSCustomTabBar.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/15.
//  Copyright © 2017年 MrSong. All rights reserved.
//

//环形间距
#define SPACE_CERTER_BTN 3


#import "MSCustomTabBar.h"

@interface MSCustomTabBar	()

 /// 中间凸起的按钮
@property (nonatomic, strong) UIButton *centerBtn;

@property (nonatomic, strong) CAShapeLayer		*circleLayer;

@property (nonatomic, strong) UIBezierPath		*cirCleBezierPath;



@end


@implementation MSCustomTabBar

-(instancetype)init
{
 self = [super init];
 if (self)
  {
  

  [self addSubview:self.centerBtn];
    [self.layer addSublayer:self.circleLayer];
 }
  return self;
}



- (void)layoutSubviews
{
 [super layoutSubviews];
  // 把 tabBarButton 取出来（把 tabBar 的 subViews 打印出来就明白了）
 NSMutableArray *tabBarButtonArray = [NSMutableArray array];
 for (UIView *view in self.subviews) {
  if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
	[tabBarButtonArray addObject:view];
  }
 }
 
 CGFloat barWidth = self.bounds.size.width;
 CGFloat barHeight = self.bounds.size.height;
 CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
 
  //按钮高度
 CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
 
  // 设置中间按钮的位置，居中，凸起一丢丢 中心点向上挪动了5个单位
 self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 5);
 
  // 重新布局其他 tabBarItem
  // 平均分配其他 tabBarItem 的宽度
 CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
  // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
 [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
  
  CGRect frame = view.frame;
  if (idx >= tabBarButtonArray.count / 2) {
	 // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
	frame.origin.x = idx * barItemWidth + centerBtnWidth;
  } else {
	frame.origin.x = idx * barItemWidth;
  }
	// 重新设置宽度
  frame.size.width = barItemWidth;
  view.frame = frame;
 }];
  // 把中间按钮带到视图最前面
 [self bringSubviewToFront:self.centerBtn];
 
 
  //计算高度
 CGPoint buttonCenterPoint = self.centerBtn.center;
 
  //曲线半径
 CGFloat radius =centerBtnHeight/2.0f+SPACE_CERTER_BTN;
 
 
 CGFloat h1 = self.centerBtn.center.y;
 
 CGFloat r   = radius;
 
  //具体公式为下面
 CGFloat space = sqrt(1-pow((h1/r),2))*r;
 
 CGPoint begainPoint = (CGPoint){buttonCenterPoint.x-space,0};
 
 
 [self.cirCleBezierPath removeAllPoints];
 [_cirCleBezierPath moveToPoint:begainPoint];
 
 
 CGFloat startAngle =M_PI+asin(h1/r);
 
 CGFloat endAngle = M_PI*2-asin(h1/r);
 
 
 
 [_cirCleBezierPath addArcWithCenter:buttonCenterPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
 
 _circleLayer.fillColor = [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:0.98].CGColor;
 
 _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;

 self.circleLayer.path = _cirCleBezierPath.CGPath;
 
 
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
 if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
  return nil;
 }
 UIView *result = [super hitTest:point withEvent:event];
  // 如果事件发生在 tabbar 里面直接返回
 if (result) {
  return result;
 }
  // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
 for (UIView *subview in self.subviews) {
	// 把这个坐标从tabbar的坐标系转为 subview 的坐标系
  CGPoint subPoint = [subview convertPoint:point fromView:self];
  result = [subview hitTest:subPoint withEvent:event];
	// 如果事件发生在 subView 里就返回
  if (result) {
	return result;
  }
 }
 return nil;
}

- (UIButton *)centerBtn
{
 if (_centerBtn == nil) {
  _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
  [_centerBtn setImage:[UIImage imageNamed:@"centerIcon"] forState:UIControlStateNormal];
  [_centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
 }
 return _centerBtn;
}


-(CAShapeLayer *)circleLayer
{
 if (_circleLayer==nil)
  {
		_circleLayer = [CAShapeLayer layer];
  }
	return _circleLayer;
}

-(UIBezierPath *)cirCleBezierPath
{
 if (_cirCleBezierPath==nil)
  {
		_cirCleBezierPath = [UIBezierPath bezierPath];
  }
	return _cirCleBezierPath;
}



-(void)clickCenterBtn:(UIButton *)button
{
 
}

@end
