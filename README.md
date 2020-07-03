# Project 3 - *Bri's Twitter App*

**Bri's Twitter Appp** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.

The following **stretch** features are implemented:

- [ ] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ ] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Making one API call method for (un)retweeting and (un)liking since the call is the same besides the URL endpoint.
2. Getting buttons that have PNG images so that the background in transparent. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:
  User sees app icon in home screen and styled launch screen
<img src='http://g.recordit.co/Q6YCnpp38n.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
  In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
  User should display the relative timestamp for each tweet "8m", "7h"
  User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
  Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.
<img src='http://g.recordit.co/nSjmZM3Spx.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
  User can view last 20 tweets from their home timeline 
  User can pull to refresh.
<img src='http://g.recordit.co/RefWE35xBL.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
  User can compose a new tweet by tapping on a compose button.
<img src='http://g.recordit.co/6kDH4thXJ1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
  User can sign in using OAuth login flow
  User can Logout
<img src='http://g.recordit.co/oLy1t0bGCg.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
  Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
<img src='http://g.recordit.co/LW5MhnGOSk.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [RecordIt](https://recordit.co/).

## Notes
- Had multiple issues while working with branches for my repo. On multiple occasions my working file was not my most up to date version. Need better understanding of the processes behind pushing, pulling, and merging.
- At the beginning of the project, I had little understanding of the block structure used for the API Manager. 
- Multiple properties were labeled as (nonatomic, weak) so the data was not being maintained. 
- Had an issue with my storyboard not updating, and it was due to a class in a depreciated pod. (TTTAttributes)
- Had to implement an if statement in order to use multiple segues from the same veiw controller. 
- Would like to implement infinite scrolling as well as the user profile feature and getting things like photos to load in tweets.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - handles date and time in iOS

## License

    Copyright [2020] [Briana Mason]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
