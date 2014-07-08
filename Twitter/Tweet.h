//
//  Tweet.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "User.h"

@interface Tweet : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *idStr;
@property (nonatomic, copy, readonly) User *user;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) Tweet *retweetedTweet;
@property (nonatomic, readonly) NSInteger retweetCount;
@property (nonatomic, readonly) NSInteger favoriteCount;

@end
