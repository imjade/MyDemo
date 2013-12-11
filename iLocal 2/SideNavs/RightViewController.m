//
//  RightViewController.m
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-24.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark --- 显示,隐藏 ----
-(void)MakeVisible:(BOOL)isVisible {
    self.view.hidden = isVisible;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
