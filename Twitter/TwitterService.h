//
//  TwitterService.h
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/6/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "Tweet.h"

@interface TwitterService : BDBOAuth1RequestOperationManager

+ (TwitterService *)instance;
- (void)login;
- (void)logout;

- (void) TimelineType:(NSString *)type WithSuccess:(void (^)(AFHTTPRequestOperation *operation, NSArray *tweets))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)getUserInfoWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)updateStatus:(NSString*)text
                             withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void)finishLoginWithRequestURL:(NSURL *)requestURL;
- (void)postTweet:(NSString *)tweetText success:(void (^)(AFHTTPRequestOperation *operation, Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postReply:(NSString *)tweetText toTweetWithIdStr:(NSString *)idStr success:(void (^)(AFHTTPRequestOperation *operation, Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
