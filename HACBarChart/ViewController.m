//
//  ViewController.m
//  HACBarChart
//
//  Created by Nishinobu.Takahiro on 2015/03/07.
//  Copyright (c) 2015年 Nishinobu.Takahiro. All rights reserved.
//

#import "ViewController.h"
#import "HACBarChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HACBarChart *verticalBar = [[HACBarChart alloc] initWithFrame:CGRectMake(50, 100, 50, 100)];
    [verticalBar setBarRadius:20];
    verticalBar.gradientStyle = GradientStyleGood;
    verticalBar.isHorizontal = NO;
    [self.view addSubview:verticalBar];
    [verticalBar strokeBarChart];
    
    HACBarChart *horizontalBar = [[HACBarChart alloc] initWithFrame:CGRectMake(30, 250, 200, 50)];
    horizontalBar.gradientStyle = GradientStyleBad;
    horizontalBar.isHorizontal = YES;
    [self.view addSubview:horizontalBar];
    [horizontalBar strokeBarChart];
    
    HACBarChart *barChart = [[HACBarChart alloc] initWithFrame:CGRectMake(0, 0, 150, 250)];
    barChart.backgroundColor = [UIColor blueColor];
    [barChart setBarRadius:3];
    barChart.gradientStyle = GradientStyleAttention;
    barChart.center = CGPointMake(200, 500);
    [self.view addSubview:barChart];
    [barChart strokeBarChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
