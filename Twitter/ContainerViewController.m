//
//  ContainerViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/17/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        rootViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ham-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(onHamBtn)];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        tapGestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0f green:153/255.0f blue:255/255.0f alpha:0.0f];
    self.navigationBar.translucent = NO;
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers:viewControllers];
    self.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ham-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(onHamBtn)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event handlers

- (void)onHamBtn {
    if (self.menuOpen) {
        [self.menuDelegate hideSlideout:self];
    } else {
        [self.menuDelegate showSlideout:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.menuOpen;
}

- (IBAction)onTap:(id)sender {
    if (self.menuOpen) {
        [self.menuDelegate hideSlideout:self];
    }
}


@end
