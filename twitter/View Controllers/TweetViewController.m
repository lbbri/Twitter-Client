//
//  TweetViewController.m
//  twitter
//
//  Created by brm14 on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.dateCreatedLabel.text = [NSString stringWithFormat:@"%@ ago", self.tweet.createdAtString];
    
    [self.retweetButton setSelected:self.tweet.retweeted];
    [self.likeButton setSelected:self.tweet.favorited];
    
    
    NSString *clearProfilePic = [self.tweet.user.profilePicture
     stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
     NSURL *profilePicURL = [NSURL URLWithString: clearProfilePic];
     
     //set to nil so that it does not have an old cell's image due to lagging
     self.profilePicView.image = nil;
     [self.profilePicView setImageWithURL:profilePicURL];
    
    // Do any additional setup after loading the view.
}

- (IBAction)didTapRetweet:(id)sender {
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            
            [self.retweetButton setSelected:self.tweet.retweeted];
            self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
            //NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapLike:(id)sender {
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            
            [self.likeButton setSelected:self.tweet.favorited];
            self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
            //NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
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
