//
//  TimelineViewController.m
//  fbuig
//
//  Created by jordan487 on 7/8/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "TimelineViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "DetailsViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate>

@property (strong, nonatomic) NSArray *postsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self; // view controller is the data source
    self.tableView.delegate = self; // view controller is the delegate
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self fetchPosts];
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}

- (void) fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    [query includeKey:@"profilePicture"];
    [query includeKey:@"likeCount"];
    
    //[query whereKey:@"likesCount" greaterThan:@0];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
            NSLog(@"COUNT: %lu", posts.count);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapLogoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        
        if (!error) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
        }
    }];
}

- (void)createCaption {
    [self performSegueWithIdentifier:@"timelineToComposeSegue" sender:nil];
}

- (IBAction)didTapCameraButton:(UIBarButtonItem *)sender {
    [self createCaption];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"timelineToDetailsSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *timelinePost = self.postsArray[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
            detailsViewController.post = timelinePost;
    } else {
        // do nothing
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.6];
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    
    Post *post = self.postsArray[indexPath.row];
    UIImage *image = [[UIImage alloc] initWithData:post.image.getData];

    [cell updateProperties:post.author username:post.author.username postImage:image caption:post.caption karmaWithPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self fetchPosts];
    
    [refreshControl endRefreshing];
}

- (void)didPost {
    [self viewDidLoad];
}

@end
