//
//  AppDelegate.h
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RightViewController.h"


#define kAppKey             @"4213545877"
#define kAppSecret          @"d2355f5fdbe2a5f7d4a8e80bd2a6e930"
#define kAppRedirectURI     @"http://www.baidu.com"

@class LeftViewController;
@class ViewController;
@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LeftViewController *leftVC;
    RightViewController *rightVC;
    SinaWeibo *sinaweibo;
    UINavigationController *mianNav;
}
@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *mianViewContrl;
@property (nonatomic,retain) UINavigationController *mianNav;
@property (strong, nonatomic) ViewController *viewController;
-(void)makeLeftVisible;
-(void)makeRightVisible;
-(void)makeAllDisVisible;
@end
