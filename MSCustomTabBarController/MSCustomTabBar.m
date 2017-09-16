//
//  MSCustomTabBar.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/15.
//  Copyright © 2017年 MrSong. All rights reserved.
//





#import "MSCustomTabBar.h"

#import "BarMacro.h"

#import "UIImage+imgColor.h"

#import "UIFont+add.h"


@interface MSCustomTabBar	()


@property (nonatomic, strong) CAShapeLayer		*circleLayer;

@property (nonatomic, strong) UIBezierPath		*cirCleBezierPath;

@property (nonatomic, strong) UILabel		*centerLable;

@end


@implementation MSCustomTabBar

-(instancetype)init
{
 self = [super init];
 if (self)
  {
  
    [self addSubview:self.centerBtn];
    [self addSubview:self.centerLable];
     _centerLable.text = @"佛圈";
    [self.layer addSublayer:self.circleLayer];
    [self bringSubviewToFront:_centerLable];

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
 
  //曲线半径
 CGFloat radius =centerBtnHeight/2.0f+SPACE_CERTER_BTN;
 
  // 把中间按钮带到视图最前面
 [self bringSubviewToFront:self.centerBtn];
 
 
  //计算高度
 CGPoint buttonCenterPoint = self.centerBtn.center;
 
 
 
 CGFloat h1 = self.centerBtn.center.y;
 
 CGFloat r   = radius;
 
  //具体公式为下面
 CGFloat space = sqrt(1-pow((h1/r),2))*r;
 
  CGPoint begainPoint0 = (CGPoint){0,0};
 
 CGPoint begainPoint = (CGPoint){buttonCenterPoint.x-space,0};
 
 CGPoint begainPoint2 = (CGPoint){buttonCenterPoint.x+space,0};
 
 CGPoint point3 = (CGPoint){barWidth,0};
 
 CGPoint point4 = (CGPoint){barWidth,barHeight};
  CGPoint point5 = (CGPoint){0,barHeight};
 
 [self.cirCleBezierPath removeAllPoints];
 [_cirCleBezierPath moveToPoint:begainPoint0];
 
 [_cirCleBezierPath addLineToPoint:begainPoint];
 
 
 CGFloat startAngle =M_PI+asin(h1/r);
 
 CGFloat endAngle = M_PI*2-asin(h1/r);
 
 
 
 [_cirCleBezierPath addArcWithCenter:buttonCenterPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
 
  [_cirCleBezierPath addLineToPoint:begainPoint2];
 
   [_cirCleBezierPath addLineToPoint:point3];
	[_cirCleBezierPath addLineToPoint:point4];
 	[_cirCleBezierPath addLineToPoint:point5];

 
 
 _circleLayer.fillColor = [CustomBar_BarBackGroundColor colorWithAlphaComponent:1.0f].CGColor;
 _circleLayer.lineWidth = 0.5f;
 _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;

 self.circleLayer.path = _cirCleBezierPath.CGPath;
 _centerLable.center = CGPointMake(buttonCenterPoint.x, barHeight-10);
 
 
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
  [_centerBtn setImage:[UIImage imageNamed:@"大教堂"] forState:UIControlStateNormal];
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
 
 __block UIButton *actionBtn = button;
 
 if (self.clickBtn)
 {
    _clickBtn(actionBtn);
 }
 
}

-(UILabel *)centerLable
{
 if (_centerLable==nil)
  {
		_centerLable = [[UILabel alloc]init];
  _centerLable.bounds = CGRectMake(0, 0, 70, 15);
  _centerLable.textAlignment = NSTextAlignmentCenter;
  _centerLable.font = [UIFont fontWithLocalName:@"STXINGKA.ttf" andSize:18.0f];
  _centerLable.textColor = [UIColor redColor];
  }
	return _centerLable;
}




@end
