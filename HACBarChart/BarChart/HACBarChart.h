//
//  HACBarChart.h
//  HACBarChart
//
//  Created by Nishinobu.Takahiro on 2015/03/07.
//  Copyright (c) 2015年 Nishinobu.Takahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientStyle) {
    GradientStyleGood,
    GradientStyleAttention,
    GradientStyleBad,
};

@interface HACBarChart : UIView

@property (nonatomic) BOOL isHorizontal;
@property (nonatomic) GradientStyle gradientStyle;

- (void)setBarRadius:(CGFloat)barRadius;
- (void)strokeBarChart;

@end