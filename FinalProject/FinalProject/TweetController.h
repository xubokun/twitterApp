//
//  TweetController.h
//  FinalProject
//
//  Created by Michael on 5/7/15.
//  Copyright (c) 2015 Bokun Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TweetController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    SLComposeViewController *myTweetSheet;
    
    UIImagePickerController *picker;
    UIImage *image;
    
    IBOutlet UIImageView *ImageView;
}

- (IBAction)PostToTwitter:(id)sender;
- (IBAction)PhotoLibrary:(id)sender;

@end
