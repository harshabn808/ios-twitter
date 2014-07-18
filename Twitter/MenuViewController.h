//
//  MenuViewController.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/16/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>
- (void) didSelectMenuItem:(NSInteger)index;
@end


@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *rowLabels;
@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;

@end


