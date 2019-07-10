//
//  PostCell.m
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "PostCell.h"

@interface PostCell ()

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

- (void)updateProperties:(UIImage *)image caption:(NSString *) text {
    self.postImage.image = image;
    self.captionLabel.text = text;
}

@end
