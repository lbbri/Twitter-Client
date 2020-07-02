//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCellTableViewCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"




@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource,UITableViewDelegate >

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweetsArray;

@property (nonatomic, strong) UIRefreshControl *refreshControl;



@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    //gets current users most up to date timeline
    [self fetchTimeLine];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    //add the refreshcontrol to the tableview
    [self.tableView addSubview:self.refreshControl];
    //would keep spinning if this method was not called... it calls fetchTimeLine on self
    [self.refreshControl addTarget:self action:@selector(fetchTimeLine) forControlEvents:UIControlEventValueChanged];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];

}

- (void)fetchTimeLine {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            //NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            //set Tweets array to the tweets returned from the API call
            self.tweetsArray = (NSMutableArray *)tweets;
        
        } else {
            //NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        //stop refreshing and load the table with your data
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];

    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //if you click on a tweet then...
    if([sender isKindOfClass:[TweetCellTableViewCell class]]){
        
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath= [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweetsArray[indexPath.row];
        
        TweetViewController *currentTVC = [segue destinationViewController];
        currentTVC.tweet = tweet;
        
    }
    //if you are clicking the compose button then...
    else
    {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        
    }
    
}


//necessary for UITableViewSource implementation: gets # of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}
//necessary for UITableViewSource implementation: asks data source for a cell to insert
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //use the Tweet cell that's set up on the storyboard
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    
    //this line was originally not working because tweetsArray had a weak property
    Tweet *tweet = self.tweetsArray[indexPath.row];

    
    //set all the labels and buttons to their correct value
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    
    cell.dateCreatedLabel.text = tweet.createdAtString;
    cell.tweetLabel.text = tweet.text;
    
    cell.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [cell.retweetButton setSelected:tweet.retweeted];
    [cell.likeButton setSelected:tweet.favorited];


    
    //get the profile picture url, delete the _normal for the blurry affect and change it into a URL
    NSString *clearProfilePic = [tweet.user.profilePicture
    stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
   
    NSURL *profilePicURL = [NSURL URLWithString: clearProfilePic];
    
    //set to nil so that it does not have an old cell's image due to lagging
    cell.profilePicView.image = nil;
    [cell.profilePicView setImageWithURL:profilePicURL];
    
    
    return cell;
}

//when user tweets something it is inserted into tweetsArray and the timeline is updated
- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (IBAction)didTapLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}


@end
