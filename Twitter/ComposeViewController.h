//
//  ComposeViewController.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol ComposeViewControllerDelegate <NSObject>

- (void)didPostTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Tweet *replyTo;
@property (nonatomic, weak) id <ComposeViewControllerDelegate> delegate;

@end