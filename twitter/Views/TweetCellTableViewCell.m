//
//  Tweet CellTableViewCell.m
//  twitter
//
//  Created by brm14 on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "APIManager.h"

@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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


- (void) refreshData{
    
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
}

@end
