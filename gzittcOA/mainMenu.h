//
//  mainMenu.h
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainMenuDelegat.h"
#import "rootViewDelegate.h"
#import "mainMenuCell.h"
#import "windowDelegate.h"

@interface mainMenu : UIViewController<mainMenuDelegat,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (strong,nonatomic) UILongPressGestureRecognizer *userInfoPress;
@property (strong,nonatomic) id<rootViewDelegate> rootViewDelegate;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic) NSArray *menuDataList;
@property (nonatomic,strong) NSIndexPath *defaultSelect;
@property (strong,nonatomic) id<windowDelegate> windowDelegate;

@end
