//
//  MainViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/6/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "MainViewController.h"
#import "TwitterService.h"
#import "TwitterViewController.h"

@interface MainViewController ()
- (IBAction)onLoginBtnClick:(id)sender;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginComplete) name:@"LoginCompleteNotification" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self showLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showLogin {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (IBAction)onLoginBtnClick:(id)sender {
    [[TwitterService instance] login];
}

- (void)onLoginComplete {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[TwitterViewController alloc] init]];
    nvc.navigationBar.tintColor = [UIColor whiteColor];
    nvc.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0f green:153/255.0f blue:255/255.0f alpha:0.0f];
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    nvc.navigationBar.translucent = NO;

    [self presentViewController:nvc animated:YES completion:nil];
}

@end
