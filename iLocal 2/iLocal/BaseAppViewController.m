//
//  BaseAppViewController.m
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import "BaseAppViewController.h"


/**button font size**/
#define BUTTON_FONT_SIZE 13
#define BUTTON_FONT_SIZE_FOR_TITLE 18

@interface BaseAppViewController ()

@end

@implementation BaseAppViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIBarButtonItem*)getBackButton:(NSString*)title withTarget: (id)target{
    if (title.length > 7) {
        title = @"返回";
    }
    
    UIImage *bubble = [[UIImage imageNamed:@"backto.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:14];
    title = [NSString stringWithFormat:@" %@", title];
    UIButton *backtoBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backtoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
    [backtoBtn addTarget:target action:@selector(backforward:) forControlEvents:UIControlEventTouchUpInside];
    [backtoBtn setBackgroundImage:bubble forState: UIControlStateNormal];
    [backtoBtn setTitle:title forState: UIControlStateNormal];
    
    CGSize titleSize =[backtoBtn.titleLabel.text sizeWithFont:backtoBtn.titleLabel.font
                                            constrainedToSize:CGSizeMake(backtoBtn.titleLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    [backtoBtn setFrame:CGRectMake(0, 7, titleSize.height, 28)];
    
    UIBarButtonItem *backStep = [[UIBarButtonItem alloc]initWithCustomView:backtoBtn];
    return [backStep autorelease];
}
- (UIBarButtonItem*)getRoundButton:(NSString*)title withTarget: (id)target action:(SEL)action isleft:(BOOL)isLeft {
    UIImage *bubble = [[UIImage imageNamed:@"comBtn-bg.png"]stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    UIButton *backtoBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backtoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
    backtoBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    [backtoBtn setBackgroundImage:bubble forState: UIControlStateNormal];
    [backtoBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title.length >0) {
        if (isLeft)
            title = [NSString stringWithFormat:@"%@ ",title];
        else
            title = [NSString stringWithFormat:@" %@",title];
        
        [backtoBtn setTitle:title forState: UIControlStateNormal];
        
    }
    CGSize titleSize =[backtoBtn.titleLabel.text sizeWithFont:backtoBtn.titleLabel.font
                                            constrainedToSize:CGSizeMake( MAXFLOAT,backtoBtn.titleLabel.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
    [backtoBtn setFrame:CGRectMake(0, 0, titleSize.width+15, 44)];
    
    
    UIBarButtonItem *backStep = [[UIBarButtonItem alloc]initWithCustomView:backtoBtn];
    return [backStep autorelease];
}

@end
