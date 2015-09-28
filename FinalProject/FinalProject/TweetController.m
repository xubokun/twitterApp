//
//  TweetController.m
//  FinalProject
//
//  Created by Michael on 5/7/15.
//  Copyright (c) 2015 Bokun Xu. All rights reserved.
//

#import "TweetController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface TweetController ()

@end

@implementation TweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// sheet to post to twitter
- (IBAction)PostToTwitter:(id)sender {
    myTweetSheet = [[SLComposeViewController alloc] init];
    myTweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [myTweetSheet setInitialText:@"Your Tweet"];
    //[myTweetSheet addImage:[UIImage image]];
    [myTweetSheet addImage:self->ImageView.image];
    [self presentViewController:myTweetSheet animated:YES completion:NULL];
}

// photo library
- (IBAction)PhotoLibrary:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
}


// select the picture from photo library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // set imageview to the selected image
    [ImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    // get the ref url
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    
//    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
//    NSString *imageName = [imagePath lastPathComponent];
//    
//    NSLog(imageName);
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
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
