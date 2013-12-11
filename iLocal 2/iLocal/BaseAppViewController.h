//
//  BaseAppViewController.h
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BaseAppViewController : UIViewController
{
    
}


- (UIBarButtonItem*)getBackButton:(NSString*)title withTarget: (id)target;
- (UIBarButtonItem*)getRoundButton:(NSString*)title withTarget: (id)target action:(SEL)action isleft:(BOOL)isLeft;
@end
