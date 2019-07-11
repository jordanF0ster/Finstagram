//
//  EditProfileViewController.m
//  fbuig
//
//  Created by jordan487 on 7/11/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *editProfileImageView;
@property (weak, nonatomic) IBOutlet UITextView *editBioTextView;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapEditProfileImageView:)];
    
    // Optionally set the number of required taps, e.g., 2 for a double click
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.editProfileImageView setUserInteractionEnabled:YES];
    [self.editProfileImageView addGestureRecognizer:tapGestureRecognizer];
}

- (IBAction)didTapEditProfileImageView:(UITapGestureRecognizer *)sender {
    [self createImageController];
}

- (void)createImageController {
    // instantiate an image picker controller
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    // if the camera is not present the camera roll is used
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.editProfileImageView.image = editedImage;
    
    // Do something with the images (based on your use case)
    [self setProfilePicture];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapFinishButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// sets profile picture of user
- (void)setProfilePicture {
    PFUser *user = PFUser.currentUser;
    PFFileObject *image = user[@"profilePicture"];
    image = [Post getPFFileFromImage:self.editProfileImageView.image];
    [user setObject:image forKey:@"profilePicture"];
    NSLog(@"WWWWWW: %@", image);
    
    [user saveInBackground];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
