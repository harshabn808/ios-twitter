//
//  TwitterViewController.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/6/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "TwitterCell.h"

@interface TwitterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, TwitterCellDelegate>
@property (nonatomic) NSString *type;

@end
