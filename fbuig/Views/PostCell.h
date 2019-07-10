//
//  PostCell.h
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

- (void)updateProperties:(UIImage *)image caption:(NSString *) text;

@end

NS_ASSUME_NONNULL_END
