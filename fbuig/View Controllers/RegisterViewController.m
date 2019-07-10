//
//  ViewController.m
//  fbuig
//
//  Created by jordan487 on 7/8/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// registers user
- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"registerSegue" sender:nil];
        }
    }];
}

- (IBAction)didTapLogin:(id)sender {
    // manually segue to logged in view
    [self performSegueWithIdentifier:@"registerToLoginSegue" sender:nil];
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

@end
