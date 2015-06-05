//
//  rootViewController.m
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import "rootViewController.h"

@interface rootViewController ()
@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaps:)];
    self.tapGestureRecognizer.numberOfTouchesRequired = 1;
    self.tapGestureRecognizer.numberOfTapsRequired = 1;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToView{
    NSLog(@"backToView");
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2)];
        self.view.transform = CGAffineTransformIdentity;
        [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*0.5 andY:[UIScreen mainScreen].bounds.size.height/2 andS:0.8 andA:0];
        [self.menuBgDelegate menuBgCtrlWithAlpha:0];
        [self.avatarBtnDelegate setButtonAlpha:1];
    } completion:^(BOOL finished) {
        [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    }
     ];
}

-(void)goToMenu{
    NSLog(@"goToMenu");
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view setCenter:CGPointMake(([UIScreen mainScreen].bounds.size.width/2)*2*1.2,[UIScreen mainScreen].bounds.size.height/2)];
        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f,0.8f);
        [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2 andY:[UIScreen mainScreen].bounds.size.height/2 andS:1 andA:1];
        [self.menuBgDelegate menuBgCtrlWithAlpha:1];
        [self.avatarBtnDelegate setButtonAlpha:0];
    } completion:^(BOOL finished) {
        [self.view addGestureRecognizer:self.tapGestureRecognizer];
    }
     ];
}

- (void)handleTaps:(UITapGestureRecognizer*)paramSender{
    //NSLog(@"%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    //[self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self.view.frame.size.width<[UIScreen mainScreen].bounds.size.width) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2)];
            self.view.transform = CGAffineTransformIdentity;
            [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*0.5 andY:[UIScreen mainScreen].bounds.size.height/2 andS:0.8 andA:0];
            [self.menuBgDelegate menuBgCtrlWithAlpha:0];
            [self.avatarBtnDelegate setButtonAlpha:1];
        } completion:^(BOOL finished) {
            [self.view removeGestureRecognizer:self.tapGestureRecognizer];
        }
         ];
    }else{
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.view setCenter:CGPointMake(([UIScreen mainScreen].bounds.size.width/2)*2*1.2,[UIScreen mainScreen].bounds.size.height/2)];
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f,0.8f);
            [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2 andY:[UIScreen mainScreen].bounds.size.height/2 andS:1 andA:1];
            [self.menuBgDelegate menuBgCtrlWithAlpha:1];
            [self.avatarBtnDelegate setButtonAlpha:0];
        } completion:^(BOOL finished) {
            
        }
         ];
    }
}

- (void)handlePan:(UIPanGestureRecognizer*)paramSender{
    if (paramSender.state == UIGestureRecognizerStateBegan) {
        //获得起始触摸位置
        self.startLocation = [paramSender locationInView:paramSender.view.superview];
    }
    if (paramSender.state == UIGestureRecognizerStateChanged){
        //起始点在屏幕左侧70像素内执行窗体缩放(由大缩小,左往右)
        if (self.startLocation.x<=70.0) {
            //屏幕左侧最大拖放幅度
            float rightLimit = [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width/2/2/2;
            //在屏幕左侧rightLimit像素内拖动进行窗体缩放
            if([paramSender locationInView:paramSender.view.superview].x<=rightLimit){
                CGFloat s,x,y,xc,s2,x2,y2,xc2,a;
                //触摸X轴数值大于起始点时执行的缩放计算,s为VIEW缩放比例,x,y为view中心点移动距离,xs为x轴移动比例,a为透明度,xc最前的2个相同的系数可调整后面板的X轴位置,为1.4时则与主面板最小缩放后位置相对平衡,现值为0.5
                if([paramSender locationInView:paramSender.view.superview].x >= self.startLocation.x){
                    s = 1-((1-0.8)/(rightLimit-self.startLocation.x))*([paramSender locationInView:paramSender.view.superview].x-self.startLocation.x);
                    xc = ((2*1.2)-1)/(rightLimit-self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x-self.startLocation.x);
                    x = [UIScreen mainScreen].bounds.size.width/2*(1+xc);
                    y = [UIScreen mainScreen].bounds.size.height/2;
                    
                    s2 = 0.8+((1-0.8)/(rightLimit-self.startLocation.x))*([paramSender locationInView:paramSender.view.superview].x-self.startLocation.x);
                    xc2 = 0.5-(0.5-0)/(rightLimit-self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x-self.startLocation.x);
                    x2 = [UIScreen mainScreen].bounds.size.width/2 - [UIScreen mainScreen].bounds.size.width/2*xc2;
                    y2 = [UIScreen mainScreen].bounds.size.height/2;
                    
                    a = 1/(rightLimit-self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x-self.startLocation.x);
                }else{
                    s = 1;
                    x = [UIScreen mainScreen].bounds.size.width/2;
                    y = [UIScreen mainScreen].bounds.size.height/2;
                    
                    s2 = 0.8;
                    x2 = [UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*0.5;
                    y2 = [UIScreen mainScreen].bounds.size.height/2;
                    
                    a = 0;
                }
                self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, s,s);
                self.view.center = CGPointMake(x, y);
                //NSLog(@"x2:%f,y2:%f,s2:%f,xc2:%f,a:%f",x2,y2,s2,xc2,a);
                [self.mainMenuDelegate mainMenuCtrlWithX:x2 andY:y2 andS:s2 andA:a];
                [self.menuBgDelegate menuBgCtrlWithAlpha:a];
                [self.avatarBtnDelegate setButtonAlpha:1-a];
            }else{
                [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2 andY:[UIScreen mainScreen].bounds.size.height/2 andS:1 andA:1];
                [self.menuBgDelegate menuBgCtrlWithAlpha:1];
            }
        }else{
            //起始点在屏幕左侧70像素以外执行窗体缩放(由小放大,右往左)
            if (self.view.center.x != [UIScreen mainScreen].bounds.size.width/2) {
                if([paramSender locationInView:paramSender.view.superview].x>=0){
                    CGFloat s,x,y,xc,s2,x2,y2,xc2,a;
                    if([paramSender locationInView:paramSender.view.superview].x <= self.startLocation.x){
                        s = 1-((1-0.8)/(self.startLocation.x))*([paramSender locationInView:paramSender.view.superview].x);
                        xc = ((2*1.2)-1)/(self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x);
                        x = [UIScreen mainScreen].bounds.size.width/2*(1+xc);
                        y = [UIScreen mainScreen].bounds.size.height/2;
                        
                        s2 = 0.8+((1-0.8)/(self.startLocation.x))*([paramSender locationInView:paramSender.view.superview].x);
                        xc2 = 0.5-(0.5-0)/(self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x);
                        x2 = [UIScreen mainScreen].bounds.size.width/2 - [UIScreen mainScreen].bounds.size.width/2*xc2;
                        y2 = [UIScreen mainScreen].bounds.size.height/2;
                        
                        a = 1/(self.startLocation.x)*([paramSender locationInView:paramSender.view.superview].x);
                    }else{
                        s = 0.8;
                        x = ([UIScreen mainScreen].bounds.size.width/2)*2*1.2;
                        y = [UIScreen mainScreen].bounds.size.height/2;
                        
                        s2 = 1;
                        x2 = [UIScreen mainScreen].bounds.size.width/2;
                        y2 = [UIScreen mainScreen].bounds.size.height/2;
                        
                        a = 1;
                    }
                    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, s,s);
                    self.view.center = CGPointMake(x, y);
                    [self.mainMenuDelegate mainMenuCtrlWithX:x2 andY:y2 andS:s2 andA:a];
                    [self.menuBgDelegate menuBgCtrlWithAlpha:a];
                    [self.avatarBtnDelegate setButtonAlpha:1-a];
                }
            }
        }
    }
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        //判断拖动结束位置执行窗口到位动画
        if (self.startLocation.x<=70.0) {
            if (self.view.center.x >= [UIScreen mainScreen].bounds.size.width/2+[UIScreen mainScreen].bounds.size.width/3) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.view setCenter:CGPointMake(([UIScreen mainScreen].bounds.size.width/2)*2*1.2,[UIScreen mainScreen].bounds.size.height/2)];
                    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f,0.8f);
                    [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2 andY:[UIScreen mainScreen].bounds.size.height/2 andS:1 andA:1];
                    [self.menuBgDelegate menuBgCtrlWithAlpha:1];
                    [self.avatarBtnDelegate setButtonAlpha:0];
                } completion:^(BOOL finished) {
                    [self.view addGestureRecognizer:self.tapGestureRecognizer];
                }
                 ];
            }else{
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2)];
                    self.view.transform = CGAffineTransformIdentity;
                    [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*0.5 andY:[UIScreen mainScreen].bounds.size.height/2 andS:0.8 andA:0];
                    [self.menuBgDelegate menuBgCtrlWithAlpha:0];
                    [self.avatarBtnDelegate setButtonAlpha:1];
                } completion:^(BOOL finished) {
                    
                }
                 ];
            }
        }else{
            if (self.view.center.x >= [UIScreen mainScreen].bounds.size.width/2+[UIScreen mainScreen].bounds.size.width/3) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.view setCenter:CGPointMake(([UIScreen mainScreen].bounds.size.width/2)*2*1.2,[UIScreen mainScreen].bounds.size.height/2)];
                    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f,0.8f);
                    [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2 andY:[UIScreen mainScreen].bounds.size.height/2 andS:1 andA:1];
                    [self.menuBgDelegate menuBgCtrlWithAlpha:1];
                    [self.avatarBtnDelegate setButtonAlpha:0];
                } completion:^(BOOL finished) {
                    
                }
                 ];
            }else{
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2)];
                    self.view.transform = CGAffineTransformIdentity;
                    [self.mainMenuDelegate mainMenuCtrlWithX:[UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width/2*0.5 andY:[UIScreen mainScreen].bounds.size.height/2 andS:0.8 andA:0];
                    [self.menuBgDelegate menuBgCtrlWithAlpha:0];
                    [self.avatarBtnDelegate setButtonAlpha:1];
                } completion:^(BOOL finished) {
                    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
                }
                 ];
            }
        }
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
