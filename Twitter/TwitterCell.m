//
//  TwitterCell.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "TwitterCell.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"

@interface TwitterCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPadding;

@end

@implementation TwitterCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self reloadData];
}

- (void)reloadData {
    self.profileImageView.image = nil;
    
    Tweet *tweetToDisplay;
    if (self.tweet.retweetedTweet == nil) {
        tweetToDisplay = self.tweet;
        self.retweetIcon.hidden = YES;
        self.retweetLabel.hidden = YES;
        self.topPadding.constant = 10;
    } else {
        tweetToDisplay = self.tweet.retweetedTweet;
        self.retweetIcon.hidden = NO;
        self.retweetLabel.text = [NSString stringWithFormat:@"%@ retweeted", self.tweet.user.name];
        self.retweetLabel.hidden = NO;
        self.topPadding.constant = 32;
    }
    
    [self.profileImageView setImageWithURL:tweetToDisplay.user.profileImageUrl];
    self.userNameLabel.text = tweetToDisplay.user.name;
    self.twitterHandleLabel.text = [NSString stringWithFormat:@"@%@", tweetToDisplay.user.screenName];
    self.timeLabel.text = tweetToDisplay.createdAt.shortTimeAgoSinceNow;
    self.tweetLabel.text = tweetToDisplay.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweetToDisplay.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweetToDisplay.favoriteCount];
    
}


@end
