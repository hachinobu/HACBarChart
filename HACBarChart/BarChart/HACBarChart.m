//
//  HACBarChart.m
//  HACBarChart
//
//  Created by Nishinobu.Takahiro on 2015/03/07.
//  Copyright (c) 2015年 Nishinobu.Takahiro. All rights reserved.
//

#import "HACBarChart.h"

@interface HACBarChart ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (copy, nonatomic) NSString *animationTarget;
@property (strong, nonatomic) NSNumber *animationToValue;
@property (copy, nonatomic) NSArray *gradientColors;
@property (nonatomic) UIRectCorner rectCorner;
@property (nonatomic) CGSize cornerRadii;

@end

@implementation HACBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHorizontal = NO;
        _gradientStyle = GradientStyleGood;
        _cornerRadii = CGSizeMake(7.0, 7.0);
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.clipsToBounds = NO;
        
        _gradientLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_gradientLayer];
    }
    
    return self;
}

- (void)setBarRadius:(CGFloat)barRadius {
    self.cornerRadii = CGSizeMake(barRadius, barRadius);
}

- (void)setupGradientColor {
    
    switch (self.gradientStyle) {
        case GradientStyleGood:
            self.gradientColors = @[
                                    (id)[UIColor blueColor].CGColor,
                                    (id)[UIColor greenColor].CGColor,
                                    ];
            break;
            
        case GradientStyleAttention:
            self.gradientColors = @[
                                    (id)[UIColor yellowColor].CGColor,
                                    (id)[UIColor orangeColor].CGColor,
                                    ];
            break;
            
        case GradientStyleBad:
            self.gradientColors = @[
                                    (id)[UIColor yellowColor].CGColor,
                                    (id)[UIColor redColor].CGColor,
                                    ];
            
            break;
    }
    
}

- (void)setupBarChart {
    
    [self setupGradientColor];
    self.gradientLayer.colors = self.gradientColors;
    
    //anchorPointはboundsを決めた後に変更するのが容易でないためここで設定する
    if (self.isHorizontal) {
        self.gradientLayer.anchorPoint = CGPointMake(0.0, 0.5);
        self.gradientLayer.frame = self.layer.bounds;
        self.gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        self.animationTarget = @"bounds.size.width";
        self.animationToValue = @(CGRectGetWidth(self.gradientLayer.bounds));
        self.rectCorner = (UIRectCornerTopRight | UIRectCornerBottomRight);
    }
    else {
        self.gradientLayer.anchorPoint = CGPointMake(0.5, 1.0);
        self.gradientLayer.frame = self.layer.bounds;
        self.gradientLayer.startPoint = CGPointMake(0.5, 1.0);
        self.gradientLayer.endPoint = CGPointMake(0.5, 0.0);
        self.animationTarget = @"bounds.size.height";
        self.animationToValue = @(CGRectGetHeight(self.gradientLayer.bounds));
        self.rectCorner = (UIRectCornerTopLeft | UIRectCornerTopRight);
    }
    
}


- (CAShapeLayer *)barChartMaskLayer {
    //特定の箇所だけ角丸になる四角形のベジェパス
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                   byRoundingCorners:self.rectCorner
                                                         cornerRadii:self.cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.layer.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

- (CABasicAnimation *)barChartAnimation {
    
    CABasicAnimation *extendAnimation = [CABasicAnimation animationWithKeyPath:self.animationTarget];
    extendAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    extendAnimation.fromValue = @0;
    extendAnimation.toValue = self.animationToValue;
    extendAnimation.duration = 1.0;
    
    return extendAnimation;
}

- (void)strokeBarChart {
    [self setupBarChart];
    self.layer.mask = [self barChartMaskLayer];
    self.gradientLayer.mask = [self barChartMaskLayer];
    [self.gradientLayer addAnimation:[self barChartAnimation] forKey:self.animationTarget];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
//    CGContextFillRect(context, rect);
//}

@end
