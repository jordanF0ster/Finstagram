//
//  PostCell.m
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "PostCell.h"
#import <Parse/Parse.h>

@interface PostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateProperties:(PFUser *)user username:(NSString *)name postImage:(UIImage *)image caption:(NSString *)text {
    self.usernameLabel.text = name;
    self.postImage.image = image;
    self.captionLabel.text = text;
    
    NSData *imageData = [[user objectForKey:@"profilePicture"] getData];
    UIImage *proilePicture = [[UIImage alloc] initWithData:imageData];
    
    // if user has set a profile picture
    if (imageData) {
        self.profileImage.image = proilePicture;
    }
}

@end
