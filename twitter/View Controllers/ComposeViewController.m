//
//  ComposeViewController.m
//  twitter
//
//  Created by brm14 on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancelClick:(id)sender {
    //close out self
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)tweetClick:(id)sender {
    
    //newtweet is waht is in the text field
    NSString *newTweet = self.composedTweetView.text;
    
    //API Call to post tweet
    [[APIManager shared] postStatusWithText:newTweet completion:^(Tweet *postingTweet, NSError *error) {
        if(error)
        {
            //NSLog(@"Error trying to compose Tweet: %@", error.localizedDescription);
        }
        else
        {
            //tells TimeLineViewController to insert Tweet in array and update timeline
            [self.delegate didTweet:postingTweet];
            //NSLog(@"Success");

        }
    }];
    
    //close view controller after tweet is submitted
    [self dismissViewControllerAnimated:true completion:nil];

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
