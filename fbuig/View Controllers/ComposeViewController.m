//
//  ComposeViewController.m
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "ComposeViewController.h"
#import "TimelineViewController.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapPostImage:)];
    
    // Optionally set the number of required taps, e.g., 2 for a double click
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)updateText: (UILabel *)label picture:(UIImageView *)image {
    label.text = self.captionTextView.text;
    image.image = self.postImage.image;
}

- (void)imageForCompose: (UIImage *)image {
    self.postImage.image = image;
}

- (IBAction)didTapPost:(UITapGestureRecognizer *)sender  {
    [self postImageWithCaption];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didPost];
    
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
    
    self.postImage.image = editedImage;
    // Do something with the images (based on your use case)
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postImageWithCaption {
    [Post postUserImage:self.postImage.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error FOR POSTING: %@", error.localizedDescription);
        } 
    }];
}

- (IBAction)didTapPostImage:(UITapGestureRecognizer *)sender {
    [self createImageController];
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
