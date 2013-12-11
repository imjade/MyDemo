//
//  ViewController.m
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import "ViewController.h"
#import "informationViewController.h"
#define VisibleWidth 260
#define dropOffSet 100

@interface ViewController () {
    BOOL isRightVisible;
    BOOL isMoveing;
}

@end

@implementation ViewController
//-(void)backforward:(UIButton *)sender {
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"";
    isRightVisible = YES;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *rightButton = [self getRoundButton:@"Share" withTarget:self action:@selector(shakeWeibo:) isleft:NO];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
}
#pragma mark --- ShareWeiBo ----
-(void)shakeWeibo:(UIButton *)sender {
//    if (isMoveing) {
//        return;
//    }
//    isMoveing  = YES;
    if (isRightVisible)
        [self makeToLeft];
    else
        [self reSetLocation];
    
    
    
}

#pragma mark --- Pan  ---
-(void)handlePanFrom:(UIPanGestureRecognizer *)aRecognizer {
    
    if (aRecognizer.state == UIGestureRecognizerStateBegan) {
        
    }else if (aRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat offSet = [aRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]].x;
//        NSLog(@"offSet:%f",offSet);
//        NSLog(@"self.view.frame.origin.x:%f",self.view.frame.origin.x);
        if (offSet<0 ) {
            [appDelegate makeLeftVisible];
            if (offSet < - VisibleWidth) {
                offSet = - VisibleWidth;
            }
        }else {
            [appDelegate makeRightVisible];
            if (offSet > VisibleWidth) {
                offSet = VisibleWidth;
            }
        }
        self.navigationController.view.frame =
                  CGRectMake(offSet,
                             self.navigationController.view.frame.origin.y,
                             self.navigationController.view.frame.size.width,
                             self.navigationController.view.frame.size.height);
        
    }else {
        if (self.navigationController.view.frame.origin.x > dropOffSet) {
            [self makeToRight];
        }else if (self.navigationController.view.frame.origin.x <-dropOffSet) {
            [self makeToLeft];
        }else {
             [self reSetLocation];
        }
    }
}

-(void)reSetLocation {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.frame = CGRectMake(0,
                                     self.navigationController.view.frame.origin.y,
                                     self.navigationController.view.frame.size.width,
                                     self.navigationController.view.frame.size.height);
    } completion:^(BOOL finished) {
        isMoveing = NO;
        isRightVisible = YES;
        UIControl *control = (UIControl *)[self.navigationController.view viewWithTag:8888];
        if (control) {
            [control removeFromSuperview];
            NSLog(@"destory!");
        }
    }];
    
}
-(void)makeToRight {
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.frame =
                CGRectMake(VisibleWidth,
                           self.navigationController.view.frame.origin.y,
                           self.navigationController.view.frame.size.width,
                           self.navigationController.view.frame.size.height);
    } completion:^(BOOL finished) {
        UIControl *contr = (UIControl *)[self.navigationController.view viewWithTag:8888];
        if (contr) {
            [contr removeFromSuperview];
            NSLog(@"destory!");
        }
        UIControl *control = [[[UIControl alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)] autorelease];
        control.tag  = 8888;
        [control addTarget:self action:@selector(reSetLocation) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:control];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFromContrl:)];
        [control addGestureRecognizer:panGesture];
        [panGesture release];
        
    }];
    
}
-(void)makeToLeft {
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.frame =
                    CGRectMake( - VisibleWidth,
                             self.navigationController.view.frame.origin.y,
                             self.navigationController.view.frame.size.width,
                             self.navigationController.view.frame.size.height);
    } completion:^(BOOL finished) {
        isRightVisible = NO;
        UIControl *contr = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:8888];
        if (contr) {
            [contr removeFromSuperview];
            NSLog(@"destory!");
        }
        UIControl *control = [[[UIControl alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)] autorelease];
        control.tag  = 8888;
        [control addTarget:self action:@selector(reSetLocation) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:control];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFromContrl:)];
        [control addGestureRecognizer:panGesture];
        [panGesture release];
    }];
    
}
-(void)makeToLeftwithRightButton {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.frame = CGRectMake( 0,
                                     self.navigationController.view.frame.origin.y,
                                     self.navigationController.view.frame.size.width,
                                     self.navigationController.view.frame.size.height);
    } completion:^(BOOL finished) {
        [appDelegate makeLeftVisible];
        [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.navigationController.view.frame = CGRectMake( - VisibleWidth,
                                         self.navigationController.view.frame.origin.y,
                                         self.navigationController.view.frame.size.width,
                                         self.navigationController.view.frame.size.height);
        } completion:^(BOOL finished) {
            isRightVisible = NO;
            isMoveing = NO;
            UIControl *contr = (UIControl *)[self.navigationController.view viewWithTag:8888];
            if (contr) {
                [contr removeFromSuperview];
                NSLog(@"destory!");
            }
            UIControl *control = [[[UIControl alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)] autorelease];
            control.tag  = 8888;
            [control addTarget:self action:@selector(reSetLocation) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController.view addSubview:control];
            
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFromContrl:)];
            [control addGestureRecognizer:panGesture];
            [panGesture release];
        }];
    }];
    
    
    
}
-(void)handlePanFromContrl:(UIPanGestureRecognizer *)aRecongnizer {
    if (aRecongnizer.state == UIGestureRecognizerStateBegan) {
        
    }else if (aRecongnizer.state == UIGestureRecognizerStateChanged) {
        CGFloat offSet = [aRecongnizer translationInView:[[UIApplication sharedApplication] keyWindow]].x;
//        NSLog(@"offSet:%f",offSet);
//        NSLog(@"handlePanFromContrl:%f",self.view.frame.origin.x);
        if (self.navigationController.view.frame.origin.x >0 ) {
            if (offSet < - VisibleWidth) {
                offSet = - VisibleWidth;
            }
            self.navigationController.view.frame =
                    CGRectMake(VisibleWidth + offSet,
                               self.navigationController.view.frame.origin.y,
                               self.navigationController.view.frame.size.width,
                               self.navigationController.view.frame.size.height);
            
        }else {
            
            if (offSet > VisibleWidth) {
                offSet = VisibleWidth;
            }
            self.navigationController.view.frame =
                    CGRectMake(-VisibleWidth + offSet,
                               self.navigationController.view.frame.origin.y,
                               self.navigationController.view.frame.size.width,
                               self.navigationController.view.frame.size.height);
        }
        
        
    }else {
        if (self.navigationController.view.frame.origin.x > dropOffSet) {
            [self makeToRight];
        }else if (self.navigationController.view.frame.origin.x <-dropOffSet) {
            [self makeToLeft];
        }else {
            [self reSetLocation];
        }
    }
}
- (IBAction)turn2NextPage:(id)sender {
    informationViewController *inforMation = [[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:inforMation animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
