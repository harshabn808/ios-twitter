//
//  User.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/7/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "User.h"
#import <MTLValueTransformer.h>

@implementation User

static User *_currentUser = nil;

+ (User *)currentUser {
    if (_currentUser == nil) {
        // try to load from NSUserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *archivedUser = [defaults dataForKey:@"current_user"];
        if (archivedUser) {
            _currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:archivedUser];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(User *)user {
    _currentUser = user;
    
    // save to NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (user == nil) {
        [defaults removeObjectForKey:@"current_user"];
    } else {
        NSData *archivedUser = [NSKeyedArchiver archivedDataWithRootObject:_currentUser];
        [defaults setObject:archivedUser forKey:@"current_user"];
    }
    [defaults synchronize];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"profileBannerUrl": @"profile_banner_url",
             @"profileImageUrl": @"profile_image_url",
             @"screenName": @"screen_name",
             @"followersCount": @"followers_count",
             @"followingCount": @"friends_count",
             @"tweetCount": @"statuses_count"
             };
}

+ (NSValueTransformer *)profileBannerUrlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}

+ (NSValueTransformer *)profileImageUrlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}


@end
