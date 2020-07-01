//
//  Tweet.m
//  twitter
//
//  Created by brm14 on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "NSDate+DateTools.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        //Is There a re-tweet?
        NSDictionary *originalTweet = dictionary [@"retweeted_status"];
        if(originalTweet != nil)
        {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            //Change tweet to original tweet
            dictionary = originalTweet;
        }
        
        
        //set properties
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];

        //initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        //TODO: Format and set createdAtString
        
        // Format createdAt date String
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";

        //Configure the input format to parse the date string
        NSDate *date = [formatter dateFromString:createdAtOriginalString];

        //Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        //TODO: Converts date to string
        //self.createdAtString = [formatter stringFromDate:date];
        
        //changes the date to how long ago it was 
        self.createdAtString = date.shortTimeAgoSinceNow;
        
        

    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *dictionary in dictionaries)
    {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
        //NSLog([NSString stringWithFormat:@"$%@", tweet.text]);

    }
    return tweets;
}

@end
