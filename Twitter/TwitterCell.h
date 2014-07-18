//
//  TwitterCell.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@class TwitterCell;

@protocol TwitterCellDelegate <NSObject>

- (void)didTapProfileImage:(TwitterCell *)cell;

@end

@interface TwitterCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id <TwitterCellDelegate> delegate;

@end
