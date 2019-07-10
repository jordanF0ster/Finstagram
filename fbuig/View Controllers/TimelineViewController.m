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

@interface TimelineViewController ()


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didPost:(Post *)post {
    
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
