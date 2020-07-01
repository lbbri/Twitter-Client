//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCellTableViewCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"



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

    
    [self fetchTimeLine];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    //add the refreshcontrol to the tableview
    [self.tableView addSubview:self.refreshControl];
    //would keep spinning if this method was not called... it calls fetchTimeLine on self
    [self.refreshControl addTarget:self action:@selector(fetchTimeLine) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];

}

- (void)fetchTimeLine
{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            /*for (Tweet *dictionary in tweets)
            {
            }*/
            
            self.tweetsArray = (NSMutableArray *)tweets;
            //NSLog(@"%d", self.tweetsArray.count);
        
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];

        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



//necessary for UITableViewSource implementation: gets # of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d", self.tweetsArray.count);
    return self.tweetsArray.count;
}
//necessary for UITableViewSource implementation: asks data source for a cell to insert
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //use the Movie cell I set up on the storyboard
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    //load movie at indexPath from movies array into movie dictionary, so that we can access it's id's
    //NSLog(@"%@", self.tweetsArray[indexPath.row]);
    //Tweet *tweet = self.tweetsArray[indexPath.row];
    //NSLog(@"%@", NSStringFromClass([self.tweetsArray[indexPath.row] class]));

    Tweet *tweet = self.tweetsArray[indexPath.row];
    //the property was weak
    NSLog(@" THis is the name %@", tweet.createdAtString);
    
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    
    cell.dateCreatedLabel.text = tweet.createdAtString;
    cell.tweetLabel.text = tweet.text;
    
    cell.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    //get the profile picture url, delete the _normal for the blurry affect and change it into a URL
    NSString *clearProfilePic = [tweet.user.profilePicture
    stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
   
    NSURL *profilePicURL = [NSURL URLWithString: clearProfilePic];
    
    //set to nil so that it does not have an old cell's image due to lagging
    cell.profilePicView.image = nil;
    [cell.profilePicView setImageWithURL:profilePicURL];
    
    
    return cell;
}


- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}




@end
