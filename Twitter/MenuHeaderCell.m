//
//  MenuHeaderCell.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/16/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "MenuHeaderCell.h"
#import <UIImageView+AFNetworking.h>

@interface MenuHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;


@end

@implementation MenuHeaderCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(User *)user {
    _user = user;
    [self reloadData];
}

- (void)reloadData {
    [self.profileImageView setImageWithURL:self.user.profileImageUrl];
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
}


@end
