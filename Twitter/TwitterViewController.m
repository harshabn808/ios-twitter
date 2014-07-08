//
//  TwitterViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/6/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "TwitterViewController.h"
#import "TwitterService.h"
#import "TwitterCell.h"
#import "Tweet.h"
#import "TweetDetailViewController.h"
#import "MBProgressHUD.h"
#import "MainViewController.h"

@interface TwitterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (nonatomic, strong) TwitterCell *prototypeCell;

@end

@implementation TwitterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self fetchTimeline];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"Home";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TwitterCell" bundle:nil] forCellReuseIdentifier:@"TwitterCell"];
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadTable:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void) reloadTable:(UIRefreshControl*)refreshControl {
    [self fetchTimeline];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 106; // height of a 3-line non-retweeted tweet
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell" forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    self.prototypeCell.tweet = tweet;
    [self.prototypeCell layoutIfNeeded];

    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"%f", size.height);
    //return size.height + 1;
    if (tweet.retweetedTweet == nil) {
        return 140;
    } else {
        return 160;
    }
}

- (void) fetchTimeline {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Timeline";

    [[TwitterService instance] homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *tweets) {
        self.tweets = tweets;[self.tweets arrayByAddingObjectsFromArray:tweets];
        [self.tableView reloadData];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.navigationItem.prompt = @"Fetching Timeline Failed";
        [hud hide:YES];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TweetDetailViewController *tdvc = [[TweetDetailViewController alloc] init];
    tdvc.tweet = self.tweets[indexPath.row];
    
    [self.navigationController pushViewController:tdvc animated:YES];
}

- (void) onLogout {
    [[TwitterService instance] logout];
    MainViewController *mvc = [[MainViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)onCompose {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.delegate = self;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)didPostTweet:(Tweet *)tweet {
    NSArray *temp = @[tweet];
    self.tweets = [temp arrayByAddingObjectsFromArray:self.tweets];
    [self.tableView reloadData];
}

@end
