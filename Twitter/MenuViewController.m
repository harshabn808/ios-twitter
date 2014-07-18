//
//  MenuViewController.m
//  Twitter
//
//  Created by Harsha Badami Nagaraj on 7/16/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuHeaderCell.h"
#import "User.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) MenuHeaderCell *prototypeCell;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.rowLabels = @[
            @"Profile",
            @"Timeline",
            @"Mentions",
            @"Logout"
        ];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    self.menuTableView.backgroundColor = [UIColor darkGrayColor];

    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuHeaderCell" bundle:nil] forCellReuseIdentifier:@"MenuHeaderCell"];

    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    
    self.prototypeCell = [self.menuTableView dequeueReusableCellWithIdentifier:@"MenuHeaderCell"];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowLabels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell" forIndexPath:indexPath];
    cell.textLabel.text = [self getRowLabelText:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MenuHeaderCell *header = [tableView dequeueReusableCellWithIdentifier:@"MenuHeaderCell"];
    header.user = [User currentUser];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    self.prototypeCell.user = [User currentUser];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.delegate didSelectMenuItem:indexPath.row];
}

-(NSString *) getRowLabelText:(NSInteger)index {
    return self.rowLabels[index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
