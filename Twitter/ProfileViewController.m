//
//  ProfileViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/14/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;

@end

@implementation ProfileViewController

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
    
    self.userImageView.layer.cornerRadius = 4;
    self.userImageView.clipsToBounds = YES;
    [self.userImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.userImageView.layer setBorderWidth: 3.0];
    
    self.navigationItem.title = self.user.name;
    [self.bgImageView setImageWithURL:self.user.profileBannerUrl];
    [self.userImageView setImageWithURL:self.user.profileImageUrl];
    self.usernameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.followersCount.text = [NSString stringWithFormat:@"%d", self.user.followersCount];
    self.followingCount.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    self.tweetCount.text = [NSString stringWithFormat:@"%d", self.user.tweetCount];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
