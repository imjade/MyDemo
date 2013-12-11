//
//  LeftViewController.m
//  iLocal
//
//  Created by iMac - UserDefault on 13-5-24.
//  Copyright (c) 2013年 Xiaotao. All rights reserved.
//

#import "LeftViewController.h"
#import "informationViewController.h"
#import "ViewController.h"

@interface LeftViewController ()
{
    
}

@end

@implementation LeftViewController
@synthesize userInfo;
@synthesize statuses;

-(void)dealloc {
    [userInfo release];
    [statuses release];
    [_leftTab release];
    [_imgShow release];
    [super dealloc];
}

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
    self.view.backgroundColor = [UIColor lightTextColor];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.leftTab.scrollEnabled = NO;
    self.leftTab.backgroundColor = [UIColor clearColor];
    self.imgShow.backgroundColor = [UIColor orangeColor];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    self.view.backgroundColor = [UIColor redColor];
}


- (IBAction)LoginIn:(id)sender {
    SinaWeibo *sinaweibo = [self sinaweibo];
    
//    SinaWeibo *sinaweibo = [self sinaweibo];
    if (sinaweibo.userID.length >0) {
        
//        [sinaweibo requestWithURL:@"users/show.json"
//                           params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
//                       httpMethod:@"GET"
//                         delegate:self];
//        
//        return;
        //好友列表 暂无权限
        [sinaweibo requestWithURL:@"friendships/groups.json" params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
        
        
    }else {
        [sinaweibo logIn];
    }
    
}
- (SinaWeibo *)sinaweibo
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.sinaweibo;
}
#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}
#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!",postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!",postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"request:%@",request.params);
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release];
        userInfo = [result retain];
        NSLog(@"userInfo:%@",userInfo);
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release];
        statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postImageStatusText release], postImageStatusText = nil;
    }
    
}
#pragma mark ---保存 SinaWeiboAuthData ----
-(void)storeAuthData {
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

#pragma mark --- UItableView delegate --- 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"首页";
            break;
        case 1:
            cell.textLabel.text = @"我的页面";
            break;
        case 2:
            cell.textLabel.text = @"消息";
            break;
        case 3:
            cell.textLabel.text = @"设置";
            break;
            
        default:
            break;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *viewcontrol = (ViewController *)delegate.viewController;
    [viewcontrol reSetLocation];
//    delegate.viewController 
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
//            UIViewController *mianViewContrl = []
            informationViewController *information = [[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] autorelease];
            [delegate.mianNav pushViewController:information animated:YES];
//            [delegate.viewController ];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
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

- (void)viewDidUnload {
    [self setLeftTab:nil];
    [self setImgShow:nil];
    [super viewDidUnload];
}
@end
