//
//  ComposeViewController.h
//  twitter
//
//  Created by brm14 on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextView *composedTweetView;

@end



NS_ASSUME_NONNULL_END
