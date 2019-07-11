//
//  PostCell.h
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

- (void)updateProperties:(PFUser *)user username:(NSString *)name postImage:(UIImage *)image caption:(NSString *)text karmaWithPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
