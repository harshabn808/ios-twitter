//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"
#import "ComposeViewController.h"

@interface TweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFavoritesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetedByIcon;
@property (weak, nonatomic) IBOutlet UILabel *retweetedByUserNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPadding;
- (IBAction)onReplyIcon:(id)sender;

@end

@implementation TweetDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweet";
        
        // init the nav bar items
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReplyButton)];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Tweet *tweetToDisplay;
    if (self.tweet.retweetedTweet == nil) {
        // configure the view to hide the retweeted status
        tweetToDisplay = self.tweet;
        self.retweetedByIcon.hidden = YES;
        self.retweetedByUserNameLabel.hidden = YES;
        self.topPadding.constant = 15;
    } else {
        // configure the view to show the retweeted status
        tweetToDisplay = self.tweet.retweetedTweet;
        self.retweetedByIcon.hidden = NO;
        self.retweetedByUserNameLabel.text = [NSString stringWithFormat:@"%@ retweeted", self.tweet.user.name];
        self.retweetedByUserNameLabel.hidden = NO;
        self.topPadding.constant = 40;
    }
    
    [self.userProfileImageView setImageWithURL:tweetToDisplay.user.profileImageUrl];
    self.userNameLabel.text = tweetToDisplay.user.name;
    self.userScreenNameLabel.text = [NSString stringWithFormat:@"@%@", tweetToDisplay.user.screenName];
    self.tweetTextLabel.text = tweetToDisplay.text;
    self.createdAtLabel.text = [tweetToDisplay.createdAt formattedDateWithFormat:@"M/dd/yy, hh:mm a"];
    self.numRetweetsLabel.text = [@(tweetToDisplay.retweetCount) stringValue];
    self.numFavoritesLabel.text = [@(tweetToDisplay.favoriteCount) stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event handlers

- (void)onReplyButton {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.replyTo = self.tweet;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)onReplyIcon:(id)sender {
    [self onReplyButton];
}

@end
