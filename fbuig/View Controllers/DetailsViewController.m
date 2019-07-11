//
//  DetailsViewController.m
//  fbuig
//
//  Created by jordan487 on 7/10/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailsPostImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateDetailsProperties:self.post.author.username postImage:self.post.image dateCreated:self.post.createdAt captionText:self.post.caption];
}

// assings the properties of this class to the values passed in
- (void)updateDetailsProperties:(NSString *)username postImage:(PFFileObject *)image dateCreated:(NSDate *)date captionText:(NSString *)caption {
    
    self.usernameLabel.text = username;
    // gets data of from PFFileObject
    UIImage *postImage = [[UIImage alloc] initWithData:image.getData];
    self.detailsPostImageView.image = postImage;
    self.dateCreatedLabel.text = [NSString stringWithFormat:@"%@", [date timeAgoSinceNow]];
    self.captionLabel.text = caption;
}

- (NSString *)getStringFromDate:(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

- (NSString *)timeFromNow {
    NSDate *date = [[NSDate alloc] init];
    return [date timeAgoSinceNow];
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
