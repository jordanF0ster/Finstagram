//
//  PostCellCollectionViewCell.m
//  fbuig
//
//  Created by jordan487 on 7/11/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import "PostCellCollectionViewCell.h"
#import <Parse/Parse.h>
@interface PostCellCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *userPostImageView;

@end

@implementation PostCellCollectionViewCell

- (void)updateCell:(UIImage *)image {
    self.userPostImageView.image = nil;
    self.userPostImageView.image = image;
}

@end
