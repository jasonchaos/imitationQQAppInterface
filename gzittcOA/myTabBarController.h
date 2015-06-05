//
//  NoticeTabBarController.h
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rootViewDelegate.h"
#import "avatarBtnDelegate.h"

@interface myTabBarController : UITabBarController<avatarBtnDelegate>

@property (strong,nonatomic) id<rootViewDelegate> rootViewDelegate;
@property (strong,nonatomic) UIButton *aBtn;

@end
