//
//  mainMenu.m
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import "mainMenu.h"

@interface mainMenu ()

@property (nonatomic) BOOL nibRegistered;

@end

@implementation mainMenu

@synthesize nibRegistered;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //self.view.transform = CGAffineTransformScale(self.view.transform, 0.8, 0.8);
    //self.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*1.4, [UIScreen mainScreen].bounds.size.height/2);
    CALayer *avatarlayer = [self.avatar layer];
    [avatarlayer setMasksToBounds:YES];
    [avatarlayer setCornerRadius:self.avatar.frame.size.width/2];
    self.userInfoPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoPressHandle:)];
    self.userInfoPress.minimumPressDuration = 0;
    [self.userInfoView addGestureRecognizer:self.userInfoPress];
    
    CALayer *bottomBorder = [CALayer layer];
    float height=self.userInfoView.frame.size.height-1.0f;
    float width=self.userInfoView.frame.size.width-15;
    bottomBorder.frame = CGRectMake(15.0f, height+0.5, width, 0.5f);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f].CGColor;
    [self.userInfoView.layer addSublayer:bottomBorder];
    
    //self.menuTableView.delegate = self;
    //self.menuTableView.dataSource = self;
    [self.menuTableView setBackgroundColor:[UIColor clearColor]];
    
    [self setMenuDataList:[[NSArray alloc] initWithObjects:
                           [NSArray arrayWithObjects:@"内部邮件",@"通知公告",@"协同办公",@"一周事务",@"学院通讯录", nil],
                           [NSArray arrayWithObjects:@"设置",@"关于", nil],
                           nil]];
    
    self.defaultSelect = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.menuTableView selectRowAtIndexPath:self.defaultSelect animated:NO scrollPosition:UITableViewScrollPositionNone];
    mainMenuCell *defaultCell = (mainMenuCell*)[self.menuTableView cellForRowAtIndexPath:self.defaultSelect];
    defaultCell.newsLabel.text = @"0";
    defaultCell.newsLabel.hidden = YES;
    
    [self setMenuUpdateCountWithMenuName:@"一周事务" updateCount:12];
    [self setMenuUpdateCountWithMenuName:@"内部邮件" updateCount:3];
    [self setMenuUpdateCountWithMenuName:@"设置" updateCount:1];
}

- (void)setMenuUpdateCountWithMenuName:(NSString*)menuName updateCount:(NSInteger)num{
    int sectionCount = (int)self.menuDataList.count;
    NSIndexPath *updateCellIndexPath = nil;
    for (int i=0; i<sectionCount; i++) {
        NSArray *rowArray = self.menuDataList[i];
        int rowCount = (int)rowArray.count;
        for (int i2=0; i2<rowCount; i2++) {
            if(self.menuDataList[i][i2] == menuName){
                updateCellIndexPath = [NSIndexPath indexPathForRow:i2 inSection:i];
            }
        }
    }
    if(updateCellIndexPath != nil){
        mainMenuCell *updateCell = (mainMenuCell*)[self.menuTableView cellForRowAtIndexPath:updateCellIndexPath];
        [self setNewsLabel:updateCell number:num];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger result = 0;
    if ([tableView isEqual:self.menuTableView]) {
        result = 2;
    }
    return result;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger result = 0;
    if ([tableView isEqual:self.menuTableView]) {
        switch (section) {
            case 0:
                result = 5;
                break;
            case 1:
                result = 2;
                break;
            default:
                break;
        }
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"mainMenuCell";
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:@"mainMenuCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        [self setNibRegistered:YES];
    }
    mainMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.label setText:[[self.menuDataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.label.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.7 alpha:1];
    [cell.icon setImage:[UIImage imageNamed:[[self.menuDataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    [tableView setSeparatorColor:[UIColor clearColor]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    }
    CALayer *newsLabellayer = [cell.newsLabel layer];
    [newsLabellayer setMasksToBounds:YES];
    [newsLabellayer setCornerRadius:cell.newsLabel.frame.size.width/2];
    cell.newsLabelMarginLeft.constant = [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width/2/2/2 -115;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 14;
    }
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    mainMenuCell *ownCell = (mainMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    ownCell.newsLabel.hidden = YES;
}

-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    mainMenuCell *ownCell = (mainMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (![ownCell.newsLabel.text isEqualToString:@"0"]) {
        ownCell.newsLabel.hidden = NO;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 7, [UIScreen mainScreen].bounds.size.width-15, 0.5f)];
    [line  setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:1]];
    [headerView addSubview:line];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    mainMenuCell *ownCell = (mainMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self setNewsLabel:ownCell number:0];
    [self.windowDelegate openNewPage:ownCell.label.text];
    [self.rootViewDelegate backToView];
    //[tableView deselectRowAtIndexPath:self.defaultSelect animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    mainMenuCell *ownCell = (mainMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (![ownCell.newsLabel.text isEqual: @"0"]) {
        ownCell.newsLabel.hidden = NO;
    }
}

- (void)setNewsLabel:(mainMenuCell *)cell number:(NSInteger)num{
    if (num>0) {
        cell.newsLabel.hidden = NO;
    }else{
        cell.newsLabel.hidden = YES;
    }
    if (num>=100 && num<1000) {
        //[cell.newsLabel setFont:[UIFont fontWithName:@"System" size:6.0]];
        [cell.newsLabel setFont:[UIFont systemFontOfSize:10.0]];
        cell.newsLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    }else if (num>=1000){
        [cell.newsLabel setFont:[UIFont systemFontOfSize:12.0]];
        //[cell.newsLabel setFont:[UIFont fontWithName:@"System" size:12.0]];
        cell.newsLabel.text = @"...";
    }else{
        [cell.newsLabel setFont:[UIFont systemFontOfSize:12.0]];
        //[cell.newsLabel setFont:[UIFont fontWithName:@"System" size:10.0]];
        cell.newsLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mainMenuCtrlWithX:(float)x andY:(float)y andS:(float)s andA:(float)a{
    //NSLog(@"mainMenuDelegateRun");
    self.view.center = CGPointMake(x, y);
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, s, s);
    self.view.alpha = a;
}

- (void)userInfoPressHandle:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.userInfoView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.1];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.userInfoView setBackgroundColor:[UIColor clearColor]];
        //NSLog(@"%f,%f",[sender locationInView:sender.view].x,[sender locationInView:sender.view].y);
        if ([sender locationInView:sender.view].y>=0 && [sender locationInView:sender.view].y<=sender.view.frame.size.height) {
            [self.rootViewDelegate backToView];
        }
    }
    if (sender.state == UIGestureRecognizerStateCancelled) {
        [self.userInfoView setBackgroundColor:[UIColor clearColor]];
    }
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
