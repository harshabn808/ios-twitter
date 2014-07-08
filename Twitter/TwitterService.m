//
//  TwitterService.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/6/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "TwitterService.h"
#import <MTLJSONAdapter.h>
#import "Tweet.h"

@implementation TwitterService

+ (TwitterService *)instance {
    static TwitterService * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Twitter" ofType:@"plist"];
        
        NSMutableDictionary *twitterKeys = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        instance = [[TwitterService alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:twitterKeys[@"APIKey"] consumerSecret:twitterKeys[@"APISecret"]];
    });
    
    return instance;
}

- (void)login {
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"htweets://oauth_request_token"] scope:nil success:^(BDBOAuthToken *requestToken) {
        
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
        
        
    
    } failure:^(NSError *error) {
        NSLog(@"Error fetching Request Token: %@", error);
    }];
}

- (void)logout {
    [self deauthorize];
    [User setCurrentUser:nil];
}

- (void) homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, NSArray *tweets))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [MTLJSONAdapter modelsOfClass:[Tweet class] fromJSONArray:responseObject error:nil];
        success(operation, tweets);
    }
    failure:failure];
}

- (AFHTTPRequestOperation *)getUserInfoWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:success failure:failure];
}

- (AFHTTPRequestOperation *)updateStatus:(NSString*)text
                             withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSDictionary *parameters = @{@"status": text};
    return [self POST:@"1.1/statuses/update.json" parameters:parameters success:success failure:failure];
}

- (void)finishLoginWithRequestURL:(NSURL *)requestURL {
    [self fetchAccessTokenWithPath:@"oauth/access_token"
                            method:@"POST"
                      requestToken:[BDBOAuthToken tokenWithQueryString:requestURL.query]
                           success:^(BDBOAuthToken *accessToken) {
                               [[TwitterService instance].requestSerializer saveAccessToken:accessToken];
                               [self currentUserWithSuccess:^(AFHTTPRequestOperation *operation, User *currentUser) {
                                   [User setCurrentUser:currentUser];
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginCompleteNotification" object:self];
                                   
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   NSLog(@"failed user info");
                               }];
                               [User setCurrentUser:[[User alloc] init]];
                           }
                           failure:^(NSError *error) {
                               NSLog(@"failed access token");
                           }];
}


- (void)currentUserWithSuccess:(void (^)(AFHTTPRequestOperation *operation, User *currentUser))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        User *currentUser = [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:responseObject error:nil];
        success(operation, currentUser);
    } failure:failure];
}

- (void)postTweet:(NSString *)tweetText success:(void (^)(AFHTTPRequestOperation *operation, Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status": tweetText} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [MTLJSONAdapter modelOfClass:[Tweet class] fromJSONDictionary:responseObject error:nil];
        success(operation, tweet);
    } failure:failure];
}

- (void)postReply:(NSString *)tweetText toTweetWithIdStr:(NSString *)idStr success:(void (^)(AFHTTPRequestOperation *operation, Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status": tweetText, @"in_reply_to_status_id": idStr} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [MTLJSONAdapter modelOfClass:[Tweet class] fromJSONDictionary:responseObject error:nil];
        success(operation, tweet);
    } failure:failure];
}


@end
