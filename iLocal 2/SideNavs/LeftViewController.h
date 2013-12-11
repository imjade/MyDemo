//
//  LeftViewController.h
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-24.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
//#import "BaseAppViewController.h"
#import "AppDelegate.h"

@interface LeftViewController : UIViewController <SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    NSDictionary *userInfo;
    NSArray *statuses;
    
    NSString *postStatusText;
    NSString *postImageStatusText;
    AppDelegate *delegate;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgShow;
@property (retain, nonatomic) IBOutlet UITableView *leftTab;
@property (nonatomic,retain) NSDictionary *userInfo;
@property (nonatomic,retain) NSArray *statuses;
- (IBAction)LoginIn:(id)sender;
-(void)MakeVisible:(BOOL)isVisible;
@end
