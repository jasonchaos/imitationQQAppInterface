//
//  rootViewController.h
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainMenuDelegat.h"
#import "menuBgDelegate.h"
#import "rootViewDelegate.h"
#import "avatarBtnDelegate.h"


@interface rootViewController : UINavigationController<rootViewDelegate>

@property (strong,nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong,nonatomic) UIPanGestureRecognizer * panGestureRecognizer;
@property CGPoint startLocation;

@property (strong,nonatomic) id<mainMenuDelegat> mainMenuDelegate;
@property (strong,nonatomic) id<menuBgDelegate> menuBgDelegate;
@property (strong,nonatomic) id<avatarBtnDelegate> avatarBtnDelegate;

- (void)backToView;

@end
