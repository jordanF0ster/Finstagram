//
//  ComposeViewController.h
//  fbuig
//
//  Created by jordan487 on 7/9/19.
//  Copyright © 2019 jordan487. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate <NSObject>

-(void)didPost;

@end


@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
