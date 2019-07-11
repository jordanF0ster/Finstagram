//
//  PostCell.m
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "PostCell.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface PostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@property (weak, nonatomic) IBOutlet UIButton *downvoteButton;
@property (weak, nonatomic) IBOutlet UILabel *karmaLabel;
@property (strong, nonatomic) Post *currentPost;

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

- (void)updateProperties:(PFUser *)user username:(NSString *)name postImage:(UIImage *)image caption:(NSString *)text karmaWithPost:(Post *)post {
    self.usernameLabel.text = name;
    self.postImage.image = image;
    self.captionLabel.text = text;
    
    NSData *imageData = [[user objectForKey:@"profilePicture"] getData];
    UIImage *proilePicture = [[UIImage alloc] initWithData:imageData];
    // if user has set a profile picture
    if (imageData) {
        self.profileImage.image = proilePicture;
    }
    
    
    
    self.currentPost = post;
    NSNumber *upvoteCount = [post objectForKey:@"likeCount"];
    self.karmaLabel.text = [NSString stringWithFormat:@"%@", upvoteCount];
}

- (void)refreshKarma {
    int difference = [[self.currentPost objectForKey:@"likeCount"] intValue] + [[self.currentPost objectForKey:@"downvoteCount"] intValue];
    
    NSNumber *karmaCount = [NSNumber numberWithInteger:difference];
    self.karmaLabel.text = [NSString stringWithFormat:@"%@", karmaCount];
}

- (IBAction)didTapUpvote:(id)sender {
    int upvoteCount;
    if (!self.currentPost.upvoted) {
        upvoteCount = [[self.currentPost objectForKey:@"likeCount"] intValue] + 1;
        self.currentPost.upvoted = YES;
    } else {
        upvoteCount = [[self.currentPost objectForKey:@"likeCount"] intValue] - 1;
        self.currentPost.upvoted = NO;
    }
    [self.currentPost setObject:[NSNumber numberWithInteger:upvoteCount] forKey:@"likeCount"];
    [self.currentPost saveInBackground];
    [self refreshKarma];
}

- (IBAction)didTapDownvote:(id)sender {
    int downvoteCount;
    if (!self.currentPost.downvoted) {
        downvoteCount = [[self.currentPost objectForKey:@"downvoteCount"] intValue] - 1;
        self.currentPost.downvoted = YES;
    } else {
        downvoteCount = [[self.currentPost objectForKey:@"downvoteCount"] intValue] + 1;
        self.currentPost.downvoted = NO;
    }
    [self.currentPost setObject:[NSNumber numberWithInteger:downvoteCount] forKey:@"downvoteCount"];
    [self.currentPost saveInBackground];
    [self refreshKarma];
}

@end
