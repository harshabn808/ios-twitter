//
//  ContainerViewController.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/17/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContainerViewController;

@protocol ContainerViewControllerDelegate <NSObject>

- (void)showSlideout:(ContainerViewController *)vc;
- (void)hideSlideout:(ContainerViewController *)vc;

@end

@interface ContainerViewController : UINavigationController <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id <ContainerViewControllerDelegate> menuDelegate;
@property (nonatomic) BOOL menuOpen;

@end