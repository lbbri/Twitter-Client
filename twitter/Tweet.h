//
//  Tweet.h
//  twitter
//
//  Created by brm14 on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

//Properties
@property (strong, nonatomic) NSString *idStr; // For favoriting, retweeting, and replying
@property (strong, nonatomic) NSString *text;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL retweeted;
@property (strong, nonatomic) User *user; //Contains Tweet author's name, screenname
@property (strong, nonatomic) NSString *createdAtString; //display date

//For Retweets
@property (nonatomic, strong) User *retweetedByUser; // user who retweeted

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;



@end

NS_ASSUME_NONNULL_END
