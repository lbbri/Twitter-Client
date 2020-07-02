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
    
    //set all the labels and buttons to their correct value
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.dateCreatedLabel.text = [NSString stringWithFormat:@"%@ ago", self.tweet.createdAtString];
    
    [self.retweetButton setSelected:self.tweet.retweeted];
    [self.likeButton setSelected:self.tweet.favorited];
    
    
    NSString *clearProfilePic = [self.tweet.user.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
     NSURL *profilePicURL = [NSURL URLWithString: clearProfilePic];
     
     //set to nil so that it does not have an old cell's image due to lagging
     self.profilePicView.image = nil;
     [self.profilePicView setImageWithURL:profilePicURL];
    
}

- (IBAction)didTapRetweet:(id)sender {
    //sends a request to the API to retweet the current tweet
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             //NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            //update retweet properties for tweet
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            
            [self.retweetButton setSelected:self.tweet.retweeted];
            self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
            //NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapLike:(id)sender {
    //sends a request to the API to like the current tweet
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             //NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            //update like properties for tweet
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
