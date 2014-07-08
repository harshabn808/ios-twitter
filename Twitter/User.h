//
//  User.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface User : MTLModel <MTLJSONSerializing>

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;

@property (nonatomic, copy, readonly) NSURL *profileBannerUrl;
@property (nonatomic, copy, readonly) NSURL *profileImageUrl;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *screenName;

@end
