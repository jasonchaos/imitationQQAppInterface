//
//  menuBgController.h
//  gzittcOA
//
//  Created by JasonChao on 14-10-31.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuBgDelegate.h"

@interface menuBgController : UIImageView<menuBgDelegate>

-(void)menuBgCtrlWithAlpha:(float)a;

@end
