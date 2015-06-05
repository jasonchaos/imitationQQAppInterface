//
//  mainMenuCell.h
//  gzittcOA
//
//  Created by JasonChao on 14-11-3.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsLabelMarginLeft;

@end
