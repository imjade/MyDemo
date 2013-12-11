//
//  ViewController.h
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAppViewController.h"

@interface ViewController : BaseAppViewController
{
    AppDelegate *appDelegate;
}
- (IBAction)turn2NextPage:(id)sender;
-(void)makeToRight;
-(void)makeToLeft;
-(void)reSetLocation;
@end
