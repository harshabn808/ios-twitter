//
//  HomeViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/16/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuViewController.h"
#import "TwitterViewController.h"
#import "ProfileViewController.h"
#import "MainViewController.h"
#import "TwitterService.h"
#import "ContainerViewController.h"

@interface HomeViewController ()

//@property (nonatomic, strong) ContentViewController *contentViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) ContainerViewController *containerViewController;

@end

@implementation HomeViewController

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

	self.menuViewController = [[MenuViewController alloc] init];
    self.menuViewController.delegate = self;

	[self addChildViewController:self.menuViewController];
    self.menuViewController.view.frame = self.view.frame;
	[self.view addSubview:self.menuViewController.view];
	[self.menuViewController didMoveToParentViewController:self];
    
    TwitterViewController *vc = [[TwitterViewController alloc] init];
    vc.type = @"Home";
    self.containerViewController = [[ContainerViewController alloc] initWithRootViewController:vc];
    self.containerViewController.navigationBar.translucent = NO;
    
    self.containerViewController.menuDelegate = self;
    [self addChildViewController:self.containerViewController];
    self.containerViewController.view.frame = self.view.frame;
    [self.view addSubview:self.containerViewController.view];
    [self.containerViewController didMoveToParentViewController:self];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.containerViewController.view addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Ref: http://www.raywenderlich.com/32054/how-to-create-a-slide-out-navigation-like-facebook-and-path
- (void)movePanel:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        CGFloat newX = MAX(self.containerViewController.view.center.x + translation.x, self.view.center.x);
        self.containerViewController.view.center = CGPointMake(newX, self.containerViewController.view.center.y);
        [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.containerViewController.view.center.x - self.view.center.x > self.containerViewController.view.frame.size.width / 2) {
            [self openMenu];
        } else {
            [self closeMenu];
        }
    }
}

- (void)openMenu {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.containerViewController.view.frame = CGRectMake(self.view.frame.size.width - 100, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.containerViewController.menuOpen = YES;
                         }
                     }];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.containerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.containerViewController.menuOpen = NO;
                         }
                     }];
}

- (void)showSlideout:(ContainerViewController *)vc {
    [self openMenu];
}

- (void)hideSlideout:(ContainerViewController *)vc {
    [self closeMenu];
}

- (void) didSelectMenuItem:(NSInteger)index {
    UIViewController *newViewController;
    
    switch (index) {
        case 0: {
            ProfileViewController *pvc = [[ProfileViewController alloc] init];
            pvc.user = [User currentUser];
            newViewController = pvc;
            break;
        }
        case 1: {
                TwitterViewController *tvc = [[TwitterViewController alloc] init];
                tvc.type = @"Home";
                newViewController = tvc;
            }
            break;
        
        case 2: {
                TwitterViewController *tvc = [[TwitterViewController alloc] init];
                tvc.type = @"Mentions";
                newViewController = tvc;
            }
            break;
            
        case 3:
            [self onLogout];
            return;
            
        default:
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"invalid item" userInfo:nil];
    }
    
	[self.containerViewController setViewControllers:@[newViewController]];

    [self closeMenu];
}

- (void) onLogout {
    [[TwitterService instance] logout];
    MainViewController *mvc = [[MainViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}

@end
