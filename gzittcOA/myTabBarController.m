//
//  NoticeTabBarController.m
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import "myTabBarController.h"
#import "rootViewController.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface myTabBarController ()

@end

@implementation myTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    self.aBtn.frame = CGRectMake(0, 0, 33, 33);
    [self.aBtn setBackgroundImage:[UIImage imageNamed:@"cat"] forState:UIControlStateNormal];
    [self.aBtn addTarget:self action:@selector(avatarTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.aBtn setBackgroundImage:[UIImage imageNamed:@"cat"] forState:UIControlStateHighlighted];
    
    CALayer *avatarlayer = [self.aBtn layer];
    [avatarlayer setMasksToBounds:YES];
    [avatarlayer setCornerRadius:self.aBtn.frame.size.width/2];
    
    [avatarlayer setBorderColor:RGB(255,185,115).CGColor];
    [avatarlayer setBorderWidth:1];
    
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.aBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    self.aBtn.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.aBtn.alpha = 1;
    } completion:^(BOOL finished) {
        
    }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)avatarTap:(id)sender{
    [self.rootViewDelegate goToMenu];
    NSLog(@"avatarTap!!!");
}

- (void)setButtonAlpha:(float)a{
    self.aBtn.alpha = a;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
