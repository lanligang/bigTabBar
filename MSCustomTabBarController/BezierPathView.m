//
//  BezierPathView.m
//  MusicFM
//
//  Created by Macx on 2017/9/8.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "BezierPathView.h"



@interface BezierPathView ()
{
  NSInteger _num;
 NSInteger _cutOrAdd;
}
@property (nonatomic, strong) UIBezierPath		*bPath;

@property (nonatomic, strong) CAShapeLayer		*shapLayer;

@end


@implementation BezierPathView



-(instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
 
 if (self)
 {
 _bPath = [UIBezierPath bezierPath];
 
 [_bPath moveToPoint:CGPointMake(0, 0)];
 
 CGFloat x = CGRectGetWidth(frame);
 CGFloat y = CGRectGetHeight(frame);
 
 CGPoint currentPoint =  CGPointMake(x, 0);
 
 CGPoint controlPoint1 = CGPointMake(x/4, -y);
 
 CGPoint controlPoint2 = CGPointMake(3*x/4, y);
 
 [_bPath addCurveToPoint:currentPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
 
 [_bPath addLineToPoint:(CGPoint){x,y}];
 
 [_bPath addLineToPoint:(CGPoint){0,y}];
 
 [_bPath closePath];
 
 _shapLayer = [CAShapeLayer layer];
 _shapLayer.path = _bPath.CGPath;
 _shapLayer.fillColor = [UIColor colorWithRed:224/255.0f green:255/255.0f blue:255/255.0f alpha:0.8].CGColor;
 
 _shapLayer.strokeColor = [UIColor clearColor].CGColor;

 [self.layer addSublayer:_shapLayer];
 _num = 0;
 _cutOrAdd = 5;
 

  NSTimer *time =  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(moveControlPoint) userInfo:nil repeats:YES];
 [time fire];
 [[NSRunLoop mainRunLoop]addTimer:time forMode:NSRunLoopCommonModes];
 
}
 
 return self;
 
}


-(void)moveControlPoint
{
 [_bPath removeAllPoints];
 
 [_bPath moveToPoint:CGPointMake(0, 0)];
 
 CGFloat x = CGRectGetWidth(self.bounds);
 CGFloat y = CGRectGetHeight(self.bounds);
 
 
  _num += _cutOrAdd;
 
 
 CGPoint currentPoint =  CGPointMake(x, 0);
 
 CGPoint controlPoint1 = CGPointMake(_num*x/100, -y);
 
 CGPoint controlPoint2 = CGPointMake(_num*3*x/100, y);
 
 [_bPath addCurveToPoint:currentPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
 
 [_bPath addLineToPoint:(CGPoint){x,y}];
 
 [_bPath addLineToPoint:(CGPoint){0,y}];
 
 [_bPath closePath];
 
 if (_num>=80)
 {
  _cutOrAdd = -5;
 }else if (_num<=-10){
  _cutOrAdd = 5;
 }
 _shapLayer.path = _bPath.CGPath;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
