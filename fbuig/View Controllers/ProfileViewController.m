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

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateProperties];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"editProfileSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *timelinePost = self.postsArray[indexPath.row];
        
        EditProfileViewController *editProfileViewController = [segue destinationViewController];
        //EditProfileViewController.post = timelinePost;
    }
}
*/

@end
