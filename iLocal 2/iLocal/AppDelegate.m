//
//  AppDelegate.m
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-23.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "SinaWeibo.h"

@implementation AppDelegate
@synthesize sinaweibo;
@synthesize viewController = _viewController;
@synthesize mianViewContrl;
@synthesize mianNav;

- (void)dealloc
{
    [mianNav release];
    [mianViewContrl release];
    [sinaweibo release];
    [_window release];
    [_viewController release];
    [leftVC release];
    [rightVC release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    mianNav = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    self.window.rootViewController = mianNav;
    //left
    leftVC = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    leftVC.view.frame = CGRectMake(0, 20, leftVC.view.frame.size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    UINavigationController *leftNav = [[[UINavigationController alloc] initWithRootViewController:leftVC] autorelease];
    [self.window addSubview:leftNav.view];
    
    //right
    rightVC = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil] ;
    rightVC.view.frame = CGRectMake(0, 20, rightVC.view.frame.size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    [self.window addSubview:rightVC.view];
    
    [self makeAllDisVisible];
    [self.window makeKeyAndVisible];
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:leftVC];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    return YES;
}

-(void)makeLeftVisible {
    [leftVC MakeVisible:YES];
    [rightVC MakeVisible:NO];
}

-(void)makeRightVisible {
    [leftVC MakeVisible:NO];
    [rightVC MakeVisible:YES];
}

-(void)makeAllDisVisible {
    [leftVC MakeVisible:NO];
    [rightVC MakeVisible:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
