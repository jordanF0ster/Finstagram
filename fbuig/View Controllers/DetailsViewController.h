//
//  DetailsViewController.h
//  fbuig
//
//  Created by jordan487 on 7/10/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
