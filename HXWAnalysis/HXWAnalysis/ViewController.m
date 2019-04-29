//
//  ViewController.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/26.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"analysisTest" forState:UIControlStateNormal];
    btn.frame = CGRectMake(200, 300, 100, 50);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn1];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1 setTitle:@"analysisTest" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(200, 400, 150, 50);
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
//    [self.view addGestureRecognizer:tap];

    UITapGestureRecognizer* tap2 = [UITapGestureRecognizer new];
    [tap2 addTarget:self action:@selector(tap2click:)];
    [self.view addGestureRecognizer:tap2];
}
- (void)btnClick:(id)sender{
    NSLog(@"btnClick touchUpInside");
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}
- (void)btn1Click:(id)sender{
    NSLog(@"btn1Click touchUpInside");
}

- (void)tapClick:(UITapGestureRecognizer*)tap{
    NSLog(@"tapClick:qqq");
}
- (void)tap2click:(UITapGestureRecognizer*)tap{
    NSLog(@"tapClick:qqq");
}
@end
