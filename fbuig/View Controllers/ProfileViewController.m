//
//  ProfileViewController.m
//  fbuig
//
//  Created by jordan487 on 7/10/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "EditProfileViewController.h"
#import "Post.h"
#import "PostCellCollectionViewCell.h"
#import "DetailsViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *postsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self updateProperties];
    [self fetchPostsCollectionView];
    
    [self initCollectionView];
    
}

- (void) fetchPostsCollectionView {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    
    [query includeKey:@"author"];
    //[query whereKey:@"likesCount" greaterThan:@0];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
            NSLog(@"COUNT: %lu", posts.count);
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)updateProperties {
    NSData *imageData = [[PFUser.currentUser objectForKey:@"profilePicture"] getData];
    UIImage *proilePicture = [[UIImage alloc] initWithData:imageData];
    self.profileImageView.image = proilePicture;
    self.usernameLabel.text = PFUser.currentUser.username;
}

- (IBAction)didTapEditProfileButton:(id)sender {
    [self performSegueWithIdentifier:@"editProfileSegue" sender:nil];
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat postersPerLine = 4;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumLineSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = 1.5 * itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.collectionView.contentInsetAdjustmentBehavior = NO;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"profileToDetailsSegue"]) {
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *timelinePost = self.postsArray[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = timelinePost;
    }
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCellCollectionViewCell" forIndexPath:indexPath];
    Post *post = self.postsArray[indexPath.item];
    UIImage *image = [[UIImage alloc] initWithData:post.image.getData];
    
    [cell updateCell:image];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postsArray.count;
}

@end
